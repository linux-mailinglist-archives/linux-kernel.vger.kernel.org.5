Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 624638099BD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 03:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573128AbjLHCyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 21:54:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235738AbjLHCxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 21:53:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21061737
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 18:53:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7380C433C8;
        Fri,  8 Dec 2023 02:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702004010;
        bh=N6irFgoDejeQrHblovY7KccaG0xZkVPKbD6S8AoIYMg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Gwl5icqWyuHxrxcw9NefcDWqH3ic8WqxMAU5tl7i3Cukr701iSSG9clpap7ZQeexe
         7Hp2Tuo4RS/i3QP0QwcIsG1VvbQB4vH+b8V8gOVRvjBM/pK5G7ERcQ0QX2FYCFQ8cw
         WgXUYmebMKvE7s1A35pvkO/4OZQ2vTbiBw2Nh6eBBYApD8dZfE4vlkRvRfDc4GQqco
         K87EbvKyJ1kawrmQvwgJSXiMgBDRCB1+8tik5hdDgM6eol0mVBpo9Af9S6lrOSgGos
         pnlIj6hGUvH1TpZhoryN4Fso3RYG+BnlsgsItjtu4dTRVYfqgOVtiIrLZimqK5vRnw
         NMzQG1N1WxSWA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH 1/2] ARM: dts: qcom: minor whitespace cleanup around '='
Date:   Thu,  7 Dec 2023 18:57:34 -0800
Message-ID: <170200426933.2871025.3571363968242066955.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231124095049.58618-1-krzysztof.kozlowski@linaro.org>
References: <20231124095049.58618-1-krzysztof.kozlowski@linaro.org>
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


On Fri, 24 Nov 2023 10:50:48 +0100, Krzysztof Kozlowski wrote:
> The DTS code coding style expects exactly one space before and after '='
> sign.
> 
> 

Applied, thanks!

[2/2] arm64: dts: qcom: minor whitespace cleanup around '='
      commit: dd744d7d15294816bed9d66c7f815d8b24ccd22f

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
