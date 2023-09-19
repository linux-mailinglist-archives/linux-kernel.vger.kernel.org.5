Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57247A6F0D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 01:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233680AbjISXEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 19:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233326AbjISXDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 19:03:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623FFE1;
        Tue, 19 Sep 2023 16:03:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DB36C433C8;
        Tue, 19 Sep 2023 23:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695164626;
        bh=R+S5riwK7UdxE7czIhG41d7dQ35QLGYDwF1FupTD5ns=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=VM14q1ilkV02GAjri2z4l8WkZDjIJ78vWD4TCkHYC7rtckIeiHTMzzbwxDfVQN2a5
         dXhayZOhXr40e4aHqdbrZtHABmVy9zmvO9ozASxs+bUmzG6iYyRaREhW5ckBK8FW8c
         sf2pFads+sc7DeNFeGRDBFURs7POo6XyDCCPNmZcJ/9hnYsQ+ZubvSjtRaFyLpimSW
         djBUhJ5CPQyHE0zLWorIeF6GNRZh7rE0BrrlxorBNejjsdE45oJo+5/yY0zuExJNuD
         FlDsTQ6aXpaa8Wq+XJlvmN7v0LhWiTWGEegSciI7A5rPqdgBv5aY8xWhFV/j5IWcB9
         JMacOGqZsCURA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH 1/2] arm64: dts: qcom: sc8180x: align USB DWC3 clocks with bindings
Date:   Tue, 19 Sep 2023 16:07:35 -0700
Message-ID: <169516485987.787935.15143020408632490875.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230723141849.93078-1-krzysztof.kozlowski@linaro.org>
References: <20230723141849.93078-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 23 Jul 2023 16:18:48 +0200, Krzysztof Kozlowski wrote:
> Bindings require different order of clocks for USB DWC3 nodes (sleep
> before mock_utmi).
> 
> 

Applied, thanks!

[1/2] arm64: dts: qcom: sc8180x: align USB DWC3 clocks with bindings
      commit: 1e5fd509fef100aec1cdfc3f2d60b9eccd980de4
[2/2] arm64: dts: qcom: sdm630: align USB DWC3 clocks with bindings
      commit: 5af94c7c6578b39f03efbb9b5ee1809e894a0e58

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
