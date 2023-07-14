Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55589753144
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 07:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234989AbjGNFbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 01:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234856AbjGNFau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 01:30:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930B830C4;
        Thu, 13 Jul 2023 22:30:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B419361C1A;
        Fri, 14 Jul 2023 05:30:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63DD7C433CD;
        Fri, 14 Jul 2023 05:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689312645;
        bh=KAUwI1PFbd371tUYhXROEWuBb1AuJcbHNdDWFOts2uY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TL6H3pM1uMQFN+Uwzn0ajhVK+CZTmQC3+ZqMj3Uhyr/o3Uug1b6r3WxDmLDSxF2Lp
         vrAbevjDKZlxZKmTYafNa3Tc3p6tVc5F+bvANPSTeF/gmAMUn/hK6kisvVP398fotd
         A/6f2pRVqfBimep/Frs81HkY9S250q0Djn8CaHXfFzJsUv/XMkD0fxtmMU6mYZMjE6
         yJVB8aC815KJjJlM9HtW33SQAJOsFO98vlsT0syEHeGW54n0hMtuR2v6PVPGIYPp18
         JVuqrv2g2E11BmAK/z18DZTZEqgFEmeakkkWMwKdMGsouyME0/znBRc8yw7z7vO5Es
         BDYJ2ksBbwkOQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: qrb2210-rb1: Add regulators
Date:   Thu, 13 Jul 2023 22:34:00 -0700
Message-ID: <168931284124.1538684.12508770136122106763.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230711-topic-rb1_regulator-v1-1-bc4398c35800@linaro.org>
References: <20230711-topic-rb1_regulator-v1-1-bc4398c35800@linaro.org>
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


On Tue, 11 Jul 2023 12:28:17 +0200, Konrad Dybcio wrote:
> Add and assign RPM regulators coming from PM2250.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: qrb2210-rb1: Add regulators
      commit: b4fe47d12f1f8ee82ab18803d1ab074ff3d4b368

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
