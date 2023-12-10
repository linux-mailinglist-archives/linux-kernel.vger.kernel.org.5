Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11FCE80BE2B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 00:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbjLJXVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 18:21:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232234AbjLJXVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 18:21:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945FFFD
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 15:21:20 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56030C433C7;
        Sun, 10 Dec 2023 23:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702250480;
        bh=pcYMstoIya4cKH2fPcVBC1Lh+pVLN08VVEv4hGjqVzI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nGUP9mIhM9Lb5Y/Hi+UkXq8jgKuEGaFzScefYHwkyDinOYRMkO6Wuhk0v2AuIqcyB
         qjsFVxUv5U0qKiaw/WiwsE68rJzZl8ZEV7sEcl1IhsVdPPkIQa5f9SvgVErzYM0jJ/
         ky04g2icWMhq0MhGkVV/akf1wSVegYyRj7WZoMZtdj1voqMz3nS66/PbExyeJx6OVo
         GmTCm9fMN9ULBFv0Wu23QjTSg7z7k0m+x7l7nsprzLNAQ06tR5Q8nMzNq6boZXi29x
         KGhj/OLo0XcmjYo2zZb2M293FAIml5RAUN6dLFs+UkQFHIxcWcyJPr6M1EwwRauVVc
         me4LggE/ALyOQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Luca Weiss <luca@z3ntu.xyz>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH v2 0/2] Small dtsi fixes for msm8953 SoC
Date:   Sun, 10 Dec 2023 15:25:41 -0800
Message-ID: <170225073881.1947106.8831546766942369978.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231125-msm8953-misc-fixes-v2-0-df86655841d9@z3ntu.xyz>
References: <20231125-msm8953-misc-fixes-v2-0-df86655841d9@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 25 Nov 2023 13:19:26 +0100, Luca Weiss wrote:
> Fix some small things in the qcom/msm8953.dtsi file to make dtbs_check
> happier than before.
> 
> 

Applied, thanks!

[1/2] arm64: dts: qcom: msm8953: Set initial address for memory
      commit: 24187868e195202c67c38bcc3ae28f9c6a663fb4

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
