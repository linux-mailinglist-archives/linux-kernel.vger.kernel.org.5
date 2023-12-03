Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C05AB802101
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 05:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233340AbjLCExc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 23:53:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233337AbjLCEw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 23:52:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2AEC1B2
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 20:52:08 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEED1C433AD;
        Sun,  3 Dec 2023 04:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701579127;
        bh=3IWQMAplStI32tTqlVKUtGheICzw+hofNiO3oG6ElaM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rb+m4kO3lhOFWLwquC9W8BlYmj9Z53Q1UOUHOVcNBKpeGaQfgq0V5KeFOUrlLDiae
         DKFiTSFvs4LTxCrbKgfVfq1y+ZVq9q1CsdJEwF47z1ZYv1LojkrXMh+maarQBxETmM
         m3n7qB6gGR8tuH9KIPKJFU2U8p5g8pTsgxrsFuo4f41aE0+xLivFsOL4EIR4x1PDyt
         w2RCHfotK6ouli6QSuw9egua/5uWZFFdKt4a4K8AfAHLjrK3ThKOaAr8fsVTkmtVr3
         Xn8xF0lzShZHh5yUl4Q6Ijg1pEVxZeApeGcjzja0SMmSPHoNVOEs87b8GzWpRsxHVs
         szcnvEeXI1h2A==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Raymond Hackley <raymondhackley@protonmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Nikita Travkin <nikita@trvn.ru>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH] arm64: dts: qcom: msm8916-acer-a1-724: Add notification LED
Date:   Sat,  2 Dec 2023 20:54:53 -0800
Message-ID: <170157925832.1717511.1073225570333009442.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231017125848.84311-1-raymondhackley@protonmail.com>
References: <20231017125848.84311-1-raymondhackley@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 17 Oct 2023 13:00:11 +0000, Raymond Hackley wrote:
> Acer Iconia Talk S A1-724 uses KTD2026 LED driver. However, there is
> no blue LED on it. Add it to the device tree.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: msm8916-acer-a1-724: Add notification LED
      commit: 50891bc7f1e9e65fa260c442efa7fa24b3523c96

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
