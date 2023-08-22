Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD0C7846B2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 18:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237261AbjHVQQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 12:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233571AbjHVQQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 12:16:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80AB1137;
        Tue, 22 Aug 2023 09:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=9EXhRx+AZrCOReXDG4J4yUZf9NRvZGwnvBPxaq2rdo0=; b=fUtc8yTwKvSkVJM8l8ft7T6TjL
        PhIXRvo9C08GSa9G5Mg5/CsbeodDggkjx2Zu/KBPr1di/zv4d77+v5K6nZ6b8rC2h4y6ClQ7kUZCy
        O3fBU4YIIvMb3s53w+bGsz8JPVGqmv21mmMdY3XguMnJCS78uIE9+ITQ0DzdKy2gCCWfWu9Ew28s/
        W5DFczqtFoCjqw5TaqUGLpzE68n4d2cJQxjtZRAEoO0WxHWwRE+RuKeNrGuZE8DfvCJyzvDYtu+TW
        ohtxsTSvm7W3/S2Nap/exlY0YW7v681LlNYgAq+ZOU+i+FT0+ahH5y+P1DOAWt39ogGzRZK1+JPGx
        C2HP54/Q==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qYU35-00GRvY-1H;
        Tue, 22 Aug 2023 16:16:07 +0000
Message-ID: <0f59a646-74e4-22ac-5510-25d45f8816d9@infradead.org>
Date:   Tue, 22 Aug 2023 09:16:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 2/3] wifi: ath11k: Fix a few spelling errors
Content-Language: en-US
To:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        Kalle Valo <kvalo@kernel.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org
References: <20230822-ath_spelling-v1-0-8e2698759564@quicinc.com>
 <20230822-ath_spelling-v1-2-8e2698759564@quicinc.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230822-ath_spelling-v1-2-8e2698759564@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/22/23 07:50, Jeff Johnson wrote:
> Fix a few issues flagged by 'codespell'.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath11k/dp.h    | 2 +-
>  drivers/net/wireless/ath/ath11k/dp_rx.c | 2 +-
>  drivers/net/wireless/ath/ath11k/dp_tx.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

-- 
~Randy
