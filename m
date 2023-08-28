Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E656678B794
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 20:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233186AbjH1Svs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 14:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233242AbjH1Sva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 14:51:30 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE2CC0;
        Mon, 28 Aug 2023 11:51:27 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::646])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A5690723;
        Mon, 28 Aug 2023 18:51:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A5690723
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1693248686; bh=HGjqbNYJsEsJirk7kfjvPN1UdWNJufSpFpAQCmC/rK4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=QEAK5WC7tsdVo0/TFkJooAPNitEsL3xi1L2iLuuwyDJqaRl4vU41fJWc07pJ2MBYJ
         lYn1S/EW9rGH7B9e6n9QIKz9FHBPpNb2lC/vM1QMh7ZSfz2UPmXInMxuu/Un/yydNF
         IuT0iAQICKbz3iFbhYClF7PyM5WJVkoMiQo+M1pEDgDfOOueYEt8mhCfKU/SiPAjeg
         sByD4npSJYLASjRMb9BFnMyxlLWPn7vaN5dHlCAf5d6ybuLSwUOgEGprheLvnZS0yX
         CccUHKY1K0V8Bi1IUVuhRgTUHui2QKKf+ZlBzEALfruz5YvM813RGHvBBYThQ9AHvL
         2iPAypLq7AnUA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Min-Hua Chen <minhuadotchen@gmail.com>,
        Hu Haowen <src.res@email.cn>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        linux-doc-tw-discuss@lists.sourceforge.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Min-Hua Chen <minhuadotchen@gmail.com>
Subject: Re: [PATCH v2 0/3] convert TW translation sparse.txt to RST
In-Reply-To: <20230813162915.39577-1-minhuadotchen@gmail.com>
References: <20230813162915.39577-1-minhuadotchen@gmail.com>
Date:   Mon, 28 Aug 2023 12:51:26 -0600
Message-ID: <87y1hvyp8x.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Min-Hua Chen <minhuadotchen@gmail.com> writes:

> These patches move TW sparse.txt to TW dev-tools and
> convert TW sparse.txt to RST, based on [1].
> Add the RST to toctree [2].
>
> Randy said [1]:
> "
> it would be good if someone would update/modify this
> sparse.txt file to be in Documentation/translation/zh_TW/dev-tools/
> and convert it to sparse.rst (IMO).
> "
>
> [1] https://lore.kernel.org/lkml/bfab7c5b-e4d3-d8d9-afab-f43c0cdf26cf@infradead.org/
> [2] https://lore.kernel.org/lkml/87a5uxxqf3.fsf@meer.lwn.net/
>
>
>
> Min-Hua Chen (3):
>   docs: sparse: move TW sparse.txt to TW dev-tools
>   docs: sparse: convert sparse.txt to RST
>   docs: sparse: add sparse.rst to toctree
>
>  .../translations/zh_TW/dev-tools/index.rst    | 40 +++++++++++++++++++
>  .../{sparse.txt => dev-tools/sparse.rst}      |  2 +-
>  Documentation/translations/zh_TW/index.rst    |  2 +-
>  3 files changed, 42 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/translations/zh_TW/dev-tools/index.rst
>  rename Documentation/translations/zh_TW/{sparse.txt => dev-tools/sparse.rst} (99%)

This series doesn't apply to docs-next (the final patch, in particular,
is problematic).  Can you respin and resend, please?

Thanks,

jon
