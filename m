Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C00937B6EA5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 18:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240584AbjJCQfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 12:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240430AbjJCQfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 12:35:38 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902D5A1;
        Tue,  3 Oct 2023 09:35:35 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::646])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 32E43381;
        Tue,  3 Oct 2023 16:35:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 32E43381
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1696350935; bh=jAqvvOCzJH2c+YyzVSah3IL0PULsUKKmGQwGOAoaV4Q=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Ekwc+JLMST6J76KfTLzeyc5VEy4eTwOlhkaqBPCNgAVdtoZwuGGooXs4XE2Wt7Kgq
         BGZS0HW27CLzQZeah9RT2zK62QnBc1MSlvgSIGlmwez67kY2F2hOK9v/o/0NxIAqNY
         zDppQoN79Mp5abki1Ix+3+YfvyCQOzi0uF7qRlwHvU5B6LEIUB1dsJpjMZosMMjIFF
         dRSGN3X/mDOJfIRqmzUGAzAJusHZPDMK2PUIvUMbodFamE+Y9oaHvTPMcWb3ewFeUB
         ZQ/Zwv6FYmN65Ul7uE+WvZuou8zcBDzpyCjrnQNRqIiICPaJR24dEuQ8dMsTZ9pz72
         tU7/unFf85Tyw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Hu Haowen <src.res.211@gmail.com>
Cc:     Hu Haowen <src.res.211@gmail.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v2] docs/zh_TW: update contents for zh_TW
In-Reply-To: <20230925052311.20992-1-src.res.211@gmail.com>
References: <20230925052311.20992-1-src.res.211@gmail.com>
Date:   Tue, 03 Oct 2023 10:35:34 -0600
Message-ID: <87ttr7d5pl.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hu Haowen <src.res.211@gmail.com> writes:

> The content of zh_TW was too outdated comparing to the original files.
> Consequently carry out improvements in order to both keep track of sources
> and fix several grammatical mistakes in traditional Chinese.
>
> This is a thorough rewrite of the previous patch:
>     https://lore.kernel.org/linux-doc/20230807120006.6361-1-src.res.211@gmail.com/
> in order to get rid of text damage and merging errors, created based on
> linux-next (date: Sept. 15, 2023).
>
> Signed-off-by: Hu Haowen <src.res.211@gmail.com>

This version does not apply either:

Applying: docs/zh_TW: update contents for zh_TW
.git/rebase-apply/patch:751: new blank line at EOF.
+
.git/rebase-apply/patch:1061: new blank line at EOF.
+
.git/rebase-apply/patch:1411: new blank line at EOF.
+
.git/rebase-apply/patch:1443: new blank line at EOF.
+
.git/rebase-apply/patch:1717: new blank line at EOF.
+
error: patch failed: Documentation/translations/zh_TW/process/kernel-enforcement-statement.rst:1
error: Documentation/translations/zh_TW/process/kernel-enforcement-statement.rst: patch does not apply
error: Did you hand edit your patch?

It also apparently didn't make it into lore, for reasons unknown.  Try
(yet) again?

jon
