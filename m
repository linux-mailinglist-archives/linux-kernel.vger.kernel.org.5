Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA29F770827
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 20:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjHDSsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 14:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjHDSsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 14:48:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2217CA9;
        Fri,  4 Aug 2023 11:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=R179y12/UCyAcpXD/QnHM0IfTko1D4RCCKOHnrP3mvk=; b=qPWH9tuaIc/zBnslhOYGZ2GyeF
        bMzK5ZDklvQ/FF8a9L1PF8aCc/nc1/tiPtYrInXMvpEaQ3vd7wvIqyk2zZ+SdnXuYcpJ4ESm3OaxY
        ICTnnXeZ+RMxZdofshmPMsAAK1s5yGxD2bc2uCV26r3llRL9cZwc+W17HRDXo/YY2vATVk/pgemIg
        fpzyAGY3rUBpHly3epjgMPXNRWqINk+oIzADILsO5OIGxnu+3AeEqmvzFFXYAkCRoR7/2GwIT/UFk
        B25Ie4KA24ucHyD1ZaZvN6XYXC1KYwlHXzHkdGrIQl9fXYyD5UiAhJPsMg4Dxrt80hgrD2MoBozW2
        Gk9zoKYA==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qRzq1-00D1YA-2m;
        Fri, 04 Aug 2023 18:47:50 +0000
Message-ID: <bfab7c5b-e4d3-d8d9-afab-f43c0cdf26cf@infradead.org>
Date:   Fri, 4 Aug 2023 11:47:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] docs: sparse: fix invalid link addresses
Content-Language: en-US
To:     Min-Hua Chen <minhuadotchen@gmail.com>,
        Hu Haowen <src.res@email.cn>, Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc-tw-discuss@lists.sourceforge.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230804112320.35592-1-minhuadotchen@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230804112320.35592-1-minhuadotchen@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/4/23 04:23, Min-Hua Chen wrote:
> The http and git links are invalid, replace them with valid links.
> 
> Signed-off-by: Min-Hua Chen <minhuadotchen@gmail.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

It would be good if someone would update/modify this
sparse.txt file to be in Documentation/translation/zh_TW/dev-tools/
and convert it to sparse.rst (IMO).

Thanks.

> ---
>  Documentation/translations/zh_TW/sparse.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/translations/zh_TW/sparse.txt b/Documentation/translations/zh_TW/sparse.txt
> index c9acb2c926cb..6d2d088b1060 100644
> --- a/Documentation/translations/zh_TW/sparse.txt
> +++ b/Documentation/translations/zh_TW/sparse.txt
> @@ -66,11 +66,11 @@ __bitwise"類型。
>  
>  你可以從 Sparse 的主頁獲取最新的發布版本：
>  
> -	http://www.kernel.org/pub/linux/kernel/people/josh/sparse/
> +	https://www.kernel.org/pub/software/devel/sparse/dist/
>  
>  或者，你也可以使用 git 克隆最新的 sparse 開發版本：
>  
> -	git://git.kernel.org/pub/scm/linux/kernel/git/josh/sparse.git
> +        git://git.kernel.org/pub/scm/devel/sparse/sparse.git
>  
>  一旦你下載了源碼，只要以普通用戶身份運行：
>  

-- 
~Randy
