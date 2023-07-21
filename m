Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 240F475D610
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 22:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbjGUU67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 16:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbjGUU65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 16:58:57 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 277C51FD2;
        Fri, 21 Jul 2023 13:58:57 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id AF130733;
        Fri, 21 Jul 2023 20:58:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net AF130733
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1689973136; bh=BKrxC/Zf+KTV8RRlCYpok053zxsRqUtPZLYXp40EY9s=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Rli0f6Pf/znoketiI91k3oj7nVpkqx12iRUX+iqqQe0+J3mhO3OIq+wcGSFwpNTn6
         qDKbQEP3BYwzgoB8ZN/mzAdPKnDHGftpIZuHjAdsDPfYXLelXjKaydjzzbR2UXnYuj
         /hzCkQ+4XBgXUIxObCg/CxO2va9xjJ7BFTNr/BWENx19TSuaVkCBL9agrf+4i1zHnW
         GnBcP2UDF7vEwzuwkdqNEjRyLzeNyvVpzlwAEyQozpWylZ+w4/mT/sRd8M3zszrooj
         /yrhfGEzXUhFxIq3v2bzcGdRfoe9GmHw0/bCnyUzKxFj7QuSWh4GCHXobi07U8An4b
         z/TD95fVtXMRA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2] docs: panic: cleanups for panic params
In-Reply-To: <20230715034811.9665-1-rdunlap@infradead.org>
References: <20230715034811.9665-1-rdunlap@infradead.org>
Date:   Fri, 21 Jul 2023 14:58:56 -0600
Message-ID: <87zg3pasmn.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> writes:

> Move 'panic_print' to its correct place in alphabetical order.
> Add parameter format for 'pause_on_oops'.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> ---
> v2: rebase/resend since v1 did not apply cleanly;
>
>  Documentation/admin-guide/kernel-parameters.txt |   30 +++++++-------
>  1 file changed, 15 insertions(+), 15 deletions(-)

Applied, thanks.

jon
