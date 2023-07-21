Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D228275D601
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 22:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjGUUw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 16:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjGUUwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 16:52:53 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010CC30E2;
        Fri, 21 Jul 2023 13:52:51 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 9CF717DB;
        Fri, 21 Jul 2023 20:52:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 9CF717DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1689972771; bh=/pW3hEGyg79PkXdVD5J7I9kJxt4z0s0b8Oz2Xi41fcg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=FuosDovDFfQUGlzt7vLWAoKhJSFJPCqglJQ88AGCay/dnExvK3fbueKPAq4MxpxUh
         532G8LMpEV2pqgW309UmxHBdj1HrVtyGg++sMKK5+IQz13qOuSs8YZ3GneDpdqbWbC
         pqYoXZ/gjC2UvhyzgxVcSOvSna7HKSAd4EZjI7ui5892XtE+MqgeLcsHReLNoc+w9D
         SjUc+AkD4HKPcr0A0eAYWfenzpzs8/1DNpVGf0FsGM+aTqrwMGXub+cATd36alZ1kv
         RS18kv8qS1nUe1VqJmAh1UsSrj4smd2xiZmxqQivGdJtEP+i7b8t2hOAX+8c6E1qj5
         mlm9ns9qxs6GA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] Docs: kernel-parameters: sort arm64 entries
In-Reply-To: <20230715235105.17966-1-rdunlap@infradead.org>
References: <20230715235105.17966-1-rdunlap@infradead.org>
Date:   Fri, 21 Jul 2023 14:52:50 -0600
Message-ID: <87cz0lc7h9.fsf@meer.lwn.net>
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

> Put the arm64 kernel-parameters entries into alphabetical order.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> ---
>  Documentation/admin-guide/kernel-parameters.txt |   12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Applied, thanks.

jon
