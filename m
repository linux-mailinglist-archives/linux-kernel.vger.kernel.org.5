Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB7DC7C0434
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 21:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343829AbjJJTMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 15:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343625AbjJJTMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 15:12:23 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14443AF;
        Tue, 10 Oct 2023 12:12:22 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::646])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id B190944A;
        Tue, 10 Oct 2023 19:12:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net B190944A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1696965141; bh=tIoMggfmwlkW7UV/cInDijQh8FAJzGkBo0ALP3I6Y0k=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=AFJoI+AP8OJ3Op1SBlldeV+LrUFvw/Fxhx4dH3umadVQ8sjmOYqfScq9qvSYV1sak
         O5z82r97QS7SmwktTXkZuKmVn5F+M+IGY+DUYG/vpYfyXYH5NPFjwloyK63Dci3J2C
         ysaK9lVwUwUv7CSnWNiDrVbOy5tSd7rgJQoIAfqIIFIqpobP+yTiHN02GsWOiHl+Wd
         6d5bPHqJTlXNOZspiqoDfNURWW8HxiDgQwYBL0V0wVk6DLtfo0EDXTZbvoZudERroh
         A5dk0OYrgObBkTsj2cNBEdB0K5hQ/mv5IUiwMN5LBLBQp/OKXRzGUpVG8bKIwZoemK
         r1+h1c3XjB89g==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Amos Wenger <amos@bearcove.net>, amos@bearcove.net
Cc:     David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        "open list:MEMORY HOT(UN)PLUG" <linux-mm@kvack.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/memory-hotplug: fix typo in documentation
In-Reply-To: <20231006112636.97128-1-amos@bearcove.net>
References: <20231006112636.97128-1-amos@bearcove.net>
Date:   Tue, 10 Oct 2023 13:12:21 -0600
Message-ID: <87wmvu5m22.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Amos Wenger <amos@bearcove.net> writes:

> I'm 90% sure memory hotunplugging doesn't involve a "fist" phase
>
> Signed-off-by: Amos Wenger <amos@bearcove.net>
> ---
>  Documentation/admin-guide/mm/memory-hotplug.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Depends on how hard it is to get out, perhaps :)

Applied, thanks.

jon
