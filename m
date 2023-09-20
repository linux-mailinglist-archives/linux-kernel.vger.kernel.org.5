Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A34697A7032
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 04:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbjITCKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 22:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbjITCKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 22:10:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB58C5;
        Tue, 19 Sep 2023 19:10:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F17B5C433CD;
        Wed, 20 Sep 2023 02:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695175801;
        bh=I1d5uc/9R6rdSA0sR8DEjcC/Ef9Z1bWXA9sE8rqp/Bk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=l47lUqerGDFz6XhMHSXPRNhv2gCOrMlIvIys2m5CdeZFTwV8XTD2vgALsb98UpV8D
         iW7ppMHQYQrGnMWZJ9BIrQoJAVzWbKxdWcMsWfkiRi144uppxtdRDcBSARoqkrIMcH
         OTID3CUwCgs63o/rLt+gR1QnmukP/WVeO1Cg6ZJ57BL9o02CLxG5qdSYUi3KEo5BE8
         fsdEYxCg1ehPFDgjIhdARYCqdDtoXVGUJ8joKSOY/LuNDz/9rof00zUAEaKj4sG/3v
         wwpAaNjNnuOJicx8OTtlCsiB45wo4FYrkAOwhDuZR/iYME5zvc2FZh1yx1CfCAJWbR
         7XXQmq4dyOGBA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2] arm64: dts: qcom: sc7280-crd: add Bluetooth VDDIO supply
Date:   Tue, 19 Sep 2023 19:14:01 -0700
Message-ID: <169517603988.822793.8908614443019733182.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230816060502.16789-1-krzysztof.kozlowski@linaro.org>
References: <20230816060502.16789-1-krzysztof.kozlowski@linaro.org>
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


On Wed, 16 Aug 2023 08:05:02 +0200, Krzysztof Kozlowski wrote:
> Bluetooth requires VDDIO supply and Doug Anderson suggested it is
> vreg_l18b_1p8.  Add one to satisfy `dtbs_check`:
> 
>   sc7280-crd-r3.dtb: bluetooth: 'vddio-supply' is a required property
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sc7280-crd: add Bluetooth VDDIO supply
      commit: b9a2ee03019609f580ac5cae8211371119025909

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
