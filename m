Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DAC17846DF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 18:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237556AbjHVQSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 12:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232019AbjHVQSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 12:18:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C37FE61;
        Tue, 22 Aug 2023 09:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=f4UGZDyOSDrFqR1R/9Kk4HS0aKdc83h9jDx2Kbn6Q6g=; b=UDlJHHwvvDJ7TPmtegqkcuqaf6
        qSNonz2590qKt2W4irVHudxak9C71tRzMec6vLceAbZTbnduzwhf2lDUZmgNhw8sW3feuPuwd+77P
        uyerumPOUpURPcVGCcZI0CAH0Mwgm0f8bpZjEOixRK/akykgA+a6GOs0YQq2ZnFAKRzLUnNyYLXE1
        A3frB2xZNXXMO+59POdGAMfWCBmH+sndWh+nyx2RsgDBFuyMiBDTSiU8nxrODkyv70/L3zjKwR58X
        vFR/3zkzdRBwWF9Sg+lAwwRFoj4l7YhYiINJRt1cD4iGe4xGfqUIomMKGkoM+SmFFztO4CF/6xm5d
        AccRnBJg==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qYU5N-00GTPh-1R;
        Tue, 22 Aug 2023 16:18:29 +0000
Message-ID: <768de9a1-b186-c296-e9b9-d83cee1997a6@infradead.org>
Date:   Tue, 22 Aug 2023 09:18:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 3/3] wifi: ath12k: Fix a few spelling errors
Content-Language: en-US
To:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        Kalle Valo <kvalo@kernel.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org
References: <20230822-ath_spelling-v1-0-8e2698759564@quicinc.com>
 <20230822-ath_spelling-v1-3-8e2698759564@quicinc.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230822-ath_spelling-v1-3-8e2698759564@quicinc.com>
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

Hi--

On 8/22/23 07:50, Jeff Johnson wrote:
> Fix a few issues flagged by 'codespell'.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath12k/dp.h      | 2 +-
>  drivers/net/wireless/ath/ath12k/dp_rx.c   | 2 +-
>  drivers/net/wireless/ath/ath12k/dp_tx.c   | 2 +-
>  drivers/net/wireless/ath/ath12k/mac.c     | 2 +-
>  drivers/net/wireless/ath/ath12k/rx_desc.h | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index 0f2af2f14ef7..dbaf033c2527 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -6771,7 +6771,7 @@ ath12k_mac_op_reconfig_complete(struct ieee80211_hw *hw,
>  			/* After trigger disconnect, then upper layer will
>  			 * trigger connect again, then the PN number of
>  			 * upper layer will be reset to keep up with AP
> -			 * side, hence PN number mis-match will not happened.
> +			 * side, hence PN number mismatch will not happened.

The fix is good, but preferably also s/happened/happen/.

>  			 */
>  			if (arvif->is_up &&
>  			    arvif->vdev_type == WMI_VDEV_TYPE_STA &&

-- 
~Randy
