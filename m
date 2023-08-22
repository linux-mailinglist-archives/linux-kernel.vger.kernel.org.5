Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5A47846B0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 18:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237554AbjHVQOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 12:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235063AbjHVQOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 12:14:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27340CDD;
        Tue, 22 Aug 2023 09:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=WbJceb0j/bb/B15R4sYJYNrLkYrg0NTbUG1XVKLA75s=; b=G0+/5cvJpYIrNmixCMNPKByV/7
        h2P49DuGSvaBsJhN4xJvUIt3r4vf7qy8uAFN2XHClTjZ7G8FIJgyijeVPbHlsqOkaZndr6IVU4lpv
        g1pENf+OPKBsSdGdZPGbrcasRaw9ntLth3biJLsaa2/6/YG1xt/XW6vlhLAINzjq+Y5xIb2mWI4Vv
        FicczK8GP2azHZC2HMuyh9kSKORbnzLotIcel6CIpvKVxPCLW4oRqLyIn3aHNNXMzou02W7gDzfmo
        YiseIV2pqd14SF6RZ2GYEnbmNqIVQ+Kt0sz0r8bDTpGvp7QBLk4SEj4IcVHU15W+r20uchgeSUv1w
        n7Ec1d1A==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qYU1f-00GRNI-1N;
        Tue, 22 Aug 2023 16:14:39 +0000
Message-ID: <8d8c94d0-8c15-e1c4-cbe4-a1362af4d5f7@infradead.org>
Date:   Tue, 22 Aug 2023 09:14:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/3] wifi: ath10k: Fix a few spelling errors
Content-Language: en-US
To:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        Kalle Valo <kvalo@kernel.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org
References: <20230822-ath_spelling-v1-0-8e2698759564@quicinc.com>
 <20230822-ath_spelling-v1-1-8e2698759564@quicinc.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230822-ath_spelling-v1-1-8e2698759564@quicinc.com>
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
>  drivers/net/wireless/ath/ath10k/htt.h  | 4 ++--
>  drivers/net/wireless/ath/ath10k/pci.c  | 2 +-
>  drivers/net/wireless/ath/ath10k/sdio.c | 2 +-
>  drivers/net/wireless/ath/ath10k/wmi.h  | 8 ++++----
>  4 files changed, 8 insertions(+), 8 deletions(-)
> 


Acked-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

-- 
~Randy
