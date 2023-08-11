Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D28F477958F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 19:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235573AbjHKRDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 13:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236416AbjHKRDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 13:03:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAEF04219;
        Fri, 11 Aug 2023 10:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=xH06uPs2IUBPX5lJ/3kkqtKMTl3ACTNekNbqAr3kHsM=; b=HM3KJbHc4/nUsKs7cfAJgy6p0r
        uLk0Mtzi0pTmpTkRS4PquDVOe9eQyapSKLLhR1f+t8VUAKgDg+wK/T17qnZDaEtLQWeRTBPTxGvZd
        MfJPeqb5LoofTAFW4CpGiz1s9xpW00RNL+brwCw6ngEdZcV+0jGkeDWk5+GEaXlfiy6p2c5O8hNhh
        AL73Zsxz/wQyaOJLlnccVCrYjCyuayyZUxvAk3l6Q39cuIw612J8gw+4iPDvOgmRz0cIgLGp7WvqV
        NZ45vkdqtV4byOQi4r1Y/5Np9LIXiAZ8DxCf5FwhXLZQG3yX6lA3lZotkAteGinVUKINHFe3jJIRp
        uq/dRVtw==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qUVX5-00BBaw-2E;
        Fri, 11 Aug 2023 17:02:39 +0000
Message-ID: <d5507ce1-8456-1932-3ec3-23606251aaf3@infradead.org>
Date:   Fri, 11 Aug 2023 10:02:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/2] docs: sparse: move TW sparse.txt to TW dev-tools
Content-Language: en-US
To:     Min-Hua Chen <minhuadotchen@gmail.com>,
        Hu Haowen <src.res@email.cn>, Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc-tw-discuss@lists.sourceforge.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230811153554.84571-1-minhuadotchen@gmail.com>
 <20230811153554.84571-2-minhuadotchen@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230811153554.84571-2-minhuadotchen@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/11/23 08:35, Min-Hua Chen wrote:
> Follow Randy's advice [1] to move
> Documentation/translations/zh_TW/sparse.txt
> to
> Documentation/translations/zh_TW/dev-tools/sparse.txt
> 
> [1] https://lore.kernel.org/lkml/bfab7c5b-e4d3-d8d9-afab-f43c0cdf26cf@infradead.org/
> 
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Min-Hua Chen <minhuadotchen@gmail.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  Documentation/translations/zh_TW/{ => dev-tools}/sparse.txt | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  rename Documentation/translations/zh_TW/{ => dev-tools}/sparse.txt (100%)
> 
> diff --git a/Documentation/translations/zh_TW/sparse.txt b/Documentation/translations/zh_TW/dev-tools/sparse.txt
> similarity index 100%
> rename from Documentation/translations/zh_TW/sparse.txt
> rename to Documentation/translations/zh_TW/dev-tools/sparse.txt

-- 
~Randy
