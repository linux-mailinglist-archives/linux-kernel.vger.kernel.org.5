Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 481CA8099ED
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 03:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573154AbjLHCzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 21:55:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573132AbjLHCyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 21:54:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967D311D
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 18:53:49 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85932C433B8;
        Fri,  8 Dec 2023 02:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702004029;
        bh=Uq3mdwqnalaDIGToom72ls1kQksFpiADMtHIPg/KbLI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=cY2M07WsNxf4MUZOwAroQ95Cjg2A0G4FMux4nCilQylDSlG7cbP2/CkFSgDxzYVZs
         FiuATw1qcse5HZFVrJZH85kXvsQQN7HihGz7x16RIzT/7mndulIk8CtQaMGp4/jRpN
         Ofg6AneTWKPmZZGan2mFSiq1mw7Vgq0bM3Dut9+zS3wRxRRdsJjifKKCKfGq3DgpNu
         stGYZTvogS6dkKPA0ncxsec1lctjVgYGXf/xixxmXCSAYtAgCNNXqxr8r5FEjSYnwT
         YhBl23C9fDaZab52whuXXx9ulA/6MnbCBWG2rh2zUwxYwTZQekT0DK9+JUKz9WKGSq
         lVJqht1g80YpA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robert Marko <robimarko@gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: ipq8074: Add QUP4 SPI node
Date:   Thu,  7 Dec 2023 18:57:53 -0800
Message-ID: <170200426933.2871025.13636461799951955480.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231123121324.1046164-1-robimarko@gmail.com>
References: <20231123121324.1046164-1-robimarko@gmail.com>
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


On Thu, 23 Nov 2023 13:12:54 +0100, Robert Marko wrote:
> Add node to support the QUP4 SPI controller inside of IPQ8074.
> Some devices use this bus to communicate to a Bluetooth controller.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: ipq8074: Add QUP4 SPI node
      commit: 6a25e70214fde6dcf900271c819c8d7fe7b9a4b0

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
