Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6CA67F4F59
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 19:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344151AbjKVSXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 13:23:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbjKVSXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 13:23:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D387B2;
        Wed, 22 Nov 2023 10:23:20 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C4AAC433C7;
        Wed, 22 Nov 2023 18:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700677400;
        bh=rsm/2nRii3HbKt0aA439i27NiMC571tbBfMbl0xkr98=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=ZqALDBOpZeAJOS33W+umAg2VxzMDVHcq4ryuaSj4ZcBAK4k5LAZqDxMxR9+G4rsW5
         CjS6qmm9zenFVCSMdL9AlFb3wK64w2uuSvxsWE6Zgiswk4l6ElH1lz4nAZq81ZW9vz
         bDBTZFbNBbgWVbuF08HCYP5IjR9/diucGmoHjjC0F0zwT3FYUFtrNbNE9ubnCPTfrT
         HjdM144cfV4CXQsCpmXCzc76LJy0MRxuRxLNJ0gZsDYNgsCR06AATLNbYOu6YxWjJ9
         FRTt+F8xpuIXH6X3lCbTiTm4wJ9f4FDyDRedvDxHHTk1jY+8IWrT4TwW8Mf3DPYe3t
         /XrFyoyIjq1fw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath10k: Remove unused struct ath10k_htc_frame
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231103-ath10k_htc_frame-v1-1-ff00b38a9630@quicinc.com>
References: <20231103-ath10k_htc_frame-v1-1-ff00b38a9630@quicinc.com>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     <ath10k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170067739699.158537.769046394140345550.kvalo@kernel.org>
Date:   Wed, 22 Nov 2023 18:23:18 +0000 (UTC)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Johnson <quic_jjohnson@quicinc.com> wrote:

> struct ath10k_htc_frame is unused, and since it illogically contains
> two consecutive flexible arrays, it could never be used, so remove it.
> 
> No functional changes, compile tested only.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

2bc76fef1a9a wifi: ath10k: Remove unused struct ath10k_htc_frame

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231103-ath10k_htc_frame-v1-1-ff00b38a9630@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

