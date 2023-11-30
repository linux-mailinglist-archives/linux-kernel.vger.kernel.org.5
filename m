Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39E3F7FF79C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 17:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345993AbjK3Q7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 11:59:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232306AbjK3Q7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 11:59:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2798D7D
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 08:59:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF1E7C433CB;
        Thu, 30 Nov 2023 16:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701363579;
        bh=22tNHaTzJIBbBfRc7EQUN92ROgJ2k/Qfhg6/ee+vttI=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Mny9vh9pXG31dN8btGwzKcZHB9kfNjwbNFFxFznSTbm+otM5Lxe8vMkmtRUxWDdKv
         0GxCuWJu3/asQOtxGA3rx3tkt4FKhQbj+OrHG/78Nf8AL+DIocUIXt5MvmNfdh4a+u
         WGoO7tScn7f7MgLz2dbgOsbKPK2rOHB2asgeAfXISZJVfc/m0DGO0/lx5H6IAHcPda
         AlBvdc8FGtWSOr+u16KjahKc/39bLN7OnGSeTHPzDedgTfwP+7y87e+I1qt6Bcpdeo
         T83tgWbkIpkgLFxMNlyoIzCD7IugSqZxofSrxNOdOPz61TGA3OsVX1gPk6myG6guBQ
         WxJDqWZ7JNm8Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/3] wifi: ath12k: Update Qualcomm Innovation Center, Inc.
 copyrights
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231128-ath12kcopyrights-v1-1-be0b7408cbac@quicinc.com>
References: <20231128-ath12kcopyrights-v1-1-be0b7408cbac@quicinc.com>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        <ath12k@lists.infradead.org>, <ath11k@lists.infradead.org>,
        <ath10k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170136357571.1435047.9848958403770331944.kvalo@kernel.org>
Date:   Thu, 30 Nov 2023 16:59:37 +0000 (UTC)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Johnson <quic_jjohnson@quicinc.com> wrote:

> Update the copyright for all ath12k files modified on behalf of
> Qualcomm Innovation Center, Inc. in 2023.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

3 patches applied to ath-next branch of ath.git, thanks.

05205b957661 wifi: ath12k: Update Qualcomm Innovation Center, Inc. copyrights
ea77e9398b32 wifi: ath11k: Update Qualcomm Innovation Center, Inc. copyrights
b1dc0ba41431 wifi: ath10k: Update Qualcomm Innovation Center, Inc. copyrights

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231128-ath12kcopyrights-v1-1-be0b7408cbac@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

