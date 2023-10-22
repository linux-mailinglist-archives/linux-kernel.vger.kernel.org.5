Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8D07D23A1
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 17:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbjJVPqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 11:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbjJVPqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 11:46:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B8AB4;
        Sun, 22 Oct 2023 08:46:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9F0DC433C9;
        Sun, 22 Oct 2023 15:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697989565;
        bh=hBgLuN4gmptdMYFU6Aqmt023U1kwjozrOwEimQ6osa0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yg0vO6Pq3tf9IbiBrgLcCfMD5w5/dCinx1R0rp21qXirSvlGovrhIsRtLL55CvimE
         IlQFFbtT49UhDR5dB0n2syIzk61zOo+EYWs6s/XSFGQ+RDrZx1o+QP7z5EjC4XPuwe
         Qky9chStXkYTjHDwOhWtb1q2AjFXUbehWxjsTtAYnqGw7GUUZL+xmjHanD4kyISEHe
         e4yDhON6/I5gSmJHTh0J5KA4O/+zHlDdC6MpuUee/8KvM9ZcrEnaEq7cuAxfi7QXy0
         pbIHcBV5eBz81Uqn70ACCvO1NcM4MQ4/FVyt4YAJefxIj3uPsRp3eQszhrWpMvcmTv
         rr37+pHD6fWeQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?UTF-8?q?Andr=C3=A9=20Apitzsch?= <git@apitzsch.eu>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Stephan Gerhold <stephan@gerhold.net>
Subject: Re: [PATCH 0/2] arm64: dts: qcom: longcheer l8910 and l9100: Enable RGB LED
Date:   Sun, 22 Oct 2023 08:50:13 -0700
Message-ID: <169798982353.271027.3963282631663809057.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231013-bq_leds-v1-0-cc374369fc56@apitzsch.eu>
References: <20231013-bq_leds-v1-0-cc374369fc56@apitzsch.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 13 Oct 2023 22:51:35 +0200, André Apitzsch wrote:
> With the driver for ktd2026 recently applied to linux-leds[1], the LED
> can be enabled on longcheer l8910 and l9100.
> 
> [1] https://lore.kernel.org/all/20231002-ktd202x-v6-0-26be8eefeb88@apitzsch.eu/
> 
> 

Applied, thanks!

[1/2] arm64: dts: qcom: msm8916-longcheer-l8910: Enable RGB LED
      commit: 5017b8cdb7ebeb32d7f12a05b34d58662e137dbe
[2/2] arm64: dts: qcom: msm8939-longcheer-l9100: Enable RGB LED
      commit: a21796c631734ea5cf62507e63a2479261880514

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
