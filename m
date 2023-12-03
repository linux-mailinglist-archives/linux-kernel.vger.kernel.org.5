Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5D98020FE
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 05:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233262AbjLCExD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 23:53:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233254AbjLCEwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 23:52:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2EE619A5
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 20:52:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB084C433CD;
        Sun,  3 Dec 2023 04:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701579121;
        bh=pA+FLFKuwWelK1NLR8w/NkS7oubagvVjaTi+ojO0VqE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=gN7nB0yhgW4ujiSkvpuEqSK360Rkg4/N4/GH6v6mRWGM/keT9ag4cNGu9vJJy8J9p
         d+sVV2L0ORG5rhcZK+J0INJXmUWlTVm3K48/0Sv9bDbMJtMvGz6Dgy8NFVfsjLbrX0
         gRnyaEF0IWZokWJaVU9h9K6MlFcxje+IMC89AoJjTQi9Cd7Xqwp8/SSQoj8KWTR1+p
         GoMTR5TiwqfLOO23Tn9g4U65CgUqaLoNoJZmnJ+/vVAJzMqi+la/wg4GJltM75X0G3
         Qze6KJRV8IPgQf0EYtOGpetZVagTp0VHXdY4iwD6W0BAuoTOc3t+hJ72cwNx2As9xk
         jj6cgA04UQXFg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Gianluca Boiano <morf3089@gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: msm8953: add SPI interfaces
Date:   Sat,  2 Dec 2023 20:54:47 -0800
Message-ID: <170157925834.1717511.4158281748447808778.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231013110531.84140-1-morf3089@gmail.com>
References: <20231013110531.84140-1-morf3089@gmail.com>
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


On Fri, 13 Oct 2023 13:05:31 +0200, Gianluca Boiano wrote:
> This change add spi_3, spi_5 and spi_6 interfaces to
> MSM8953 devices.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: msm8953: add SPI interfaces
      commit: be69109e93c78cb3b9c191a21fc2b54291a711da

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
