Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 721857A0A0C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 18:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241540AbjINQAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 12:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241443AbjINQAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 12:00:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A17A1FD5;
        Thu, 14 Sep 2023 09:00:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DE8EC433CB;
        Thu, 14 Sep 2023 16:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694707239;
        bh=z65jDiJhYXiqCrF+31TXNYpOkgLv4DTepLv6il1TdHw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dkoXbS/9OdtDzucDaW3k1ZSAITVrqG9S2VNfizgl9rIwddQ8a6Y02/j81kyVsPTCv
         pgE5jYBvdbyWOrrATe4JSdxjpIYWJ+r8nf6kSrEKBCLp49zXcEuaSwTi4aG4u/l3Ke
         kZLRjxxsLV+3SfenXJ71RiTeeJkD1gbfywSCIvonWEhVYPrFAarqAfcytQ3PQduTwH
         GLYa6w0dunqfoWk5gwCWsfigvaqVXWKavFZOsSgxSSbTsl3Iz5PuLDy4cTVwbqd10s
         Sp8ma8Y5Ogoej+Fdrwi7Xg4ri96C3fI/YO1H1lFINehSy5QrS/1ZXP5mt51hdwCB/v
         FdNGqrVKlxSkg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Luca Weiss <luca.weiss@fairphone.com>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: (subset) [PATCH 00/11] Initial support for the Fairphone 5 smartphone
Date:   Thu, 14 Sep 2023 09:04:27 -0700
Message-ID: <169470744878.681825.1089291695542666982.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230830-fp5-initial-v1-0-5a954519bbad@fairphone.com>
References: <20230830-fp5-initial-v1-0-5a954519bbad@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 30 Aug 2023 11:58:25 +0200, Luca Weiss wrote:
> Add support to boot up mainline kernel on the QCM6490-based Fairphone 5
> smartphone.
> 
> These patches only cover a part of the functionality brought up on
> mainline so far, with the rest needing larger dts and driver changes or
> depend on patches that are not yet merged. I will work on sending those
> once these base patches here have settled.
> 
> [...]

Applied, thanks!

[07/11] dt-bindings: arm: qcom,ids: Add SoC ID for QCM6490
        commit: ccfb4d8b606302d857a03ea29039e21029311335
[08/11] soc: qcom: socinfo: Add SoC ID for QCM6490
        commit: 59872d59d164ec67f295d6f96fe818b92973ee40

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
