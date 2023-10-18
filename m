Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539BE7CD66C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 10:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344650AbjJRI2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 04:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235168AbjJRI2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 04:28:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF84BA;
        Wed, 18 Oct 2023 01:28:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96C7AC433C8;
        Wed, 18 Oct 2023 08:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697617726;
        bh=v5UHIdxwmYituZm5VELfBrx/aD0CnXn++nmORWapCTo=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=WIntCHgUvaC/Y48RIKYl/z3/eCT2JVB6mDyv5P+Kt/kVRc+8uulOasO35hnMI1/1D
         SCF6Q21ZiI8BfwXxEdmnrbqn8rl9hCBcqqbQJveyvTRx0BT5zFHVIgJBtxmNdMrzvw
         TWUcIZ3pTLKGD561E1MXWPfzbxuFkQ9bYnEB4ZLqYwmi/zWIukJDrBYQiVDxrMiOu9
         nZ4sLSfZ7aMYFSKiK9gUiSZtn46GmejsNgjJ+d9rrpWNmlC8Z8VB5oD5jMTO5mPyHs
         ujpEip5ONCLepD1AtYv5FciZRsbjjkmMiSCNSayy08jaVVmPu3a3snTBsxDhaRkEuu
         qhsy8Eq6t9PEQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH net-next] net: wireless: ath11k: Use
 device_get_match_data()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231009172923.2457844-11-robh@kernel.org>
References: <20231009172923.2457844-11-robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169761772362.48072.11114311849759116023.kvalo@kernel.org>
Date:   Wed, 18 Oct 2023 08:28:45 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Herring <robh@kernel.org> wrote:

> Use preferred device_get_match_data() instead of of_match_device() to
> get the driver match data. With this, adjust the includes to explicitly
> include the correct headers.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

9d2c23d21aa4 wifi: ath11k: Use device_get_match_data()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231009172923.2457844-11-robh@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

