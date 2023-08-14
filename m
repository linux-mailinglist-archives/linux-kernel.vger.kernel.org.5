Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B7E77B02E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 05:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232866AbjHNDin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 23:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233056AbjHNDiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 23:38:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ACD5110;
        Sun, 13 Aug 2023 20:28:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 725DB62E6D;
        Mon, 14 Aug 2023 03:28:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0F2FC433C7;
        Mon, 14 Aug 2023 03:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691983681;
        bh=w2pAjXtDmqKkotq06cS4rBPMn4gjVZ02KPf291Dg8dQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I6sZjAMA6+Mmnk0F2DJSaif73w5pFqgL6/5j06U1XsmfAfhMqVx27rpIk0wp+B9HQ
         JCfcvFNwGg6Cy8Sabi6ioU5T6ehcV6lJHmITwwKnir6jaOky8f+0Y/7GWXqOQY3BuN
         NDq+V0ehoUZXVQDJbv7M8/xZBXW2IiozXwnmzItIde3mjHQNO9ZXCg70PUj+JZJ4AN
         cy0sh5LyZ5jM4Mt/A3f38EC7cwkY0icmUQQwcy/guXxqU/Xb87uEnMTdR88UTSuiZY
         XbkuwJFZqJMwLY7fb4fWGeI/oKoGNJ3jWMMaa3kaDuvIKcv59lN4lAfzVDWYoV2ZEq
         o7Op++AcVhK8w==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-kernel@vger.kernel.org,
        "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Nikita Travkin <nikita@trvn.ru>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v2] arm64: dts: qcom: msm8916-samsung-e5: Add touchscreen
Date:   Sun, 13 Aug 2023 20:30:48 -0700
Message-ID: <169198383996.2447609.17092291226343935968.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230812071448.4710-1-linmengbo0689@protonmail.com>
References: <20230812071448.4710-1-linmengbo0689@protonmail.com>
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


On Sat, 12 Aug 2023 07:16:56 +0000, Lin, Meng-Bo wrote:
> Similar to A5, E5 uses a Melfas MMS345L touchscreen that is connected to
> blsp_i2c5. Add it to the device tree.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: msm8916-samsung-e5: Add touchscreen
      commit: befa79798a614215521811e84e3b783a2a685595

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
