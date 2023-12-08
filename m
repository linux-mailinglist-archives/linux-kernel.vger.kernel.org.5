Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F44F8099E9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 03:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573250AbjLHCyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 21:54:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235714AbjLHCx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 21:53:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48D91720
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 18:53:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B460C433CC;
        Fri,  8 Dec 2023 02:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702004024;
        bh=7Y8XKefUpcS7h4WyLwRjwdyYfEpECpluqg4Ut7OmPo4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lj5nBKVHajJpWArNrqb04bZTknHZAOoBb1awvf3qraAhqWduI+myT8yNms7fiRk/y
         rjbXrAJUzY05uxUN4pF9It/HqhP0jr8+0HZGS/IEXuvEvUdBGHgak0FoWJNkDcxlXh
         cnd8WotrYzwDTfD81j+S4mJlZrfWbfAyNPJw49t9UfUNRnsxadWMEkgu8s9Dv6g2Uk
         rcM/EXdSuviLV+5B2ulmyH8vP+/P0Jb2AU28eNst7wqWMZ3xrXp20xjaEff8QmXVXT
         zH4CCQiJFiiAUIbiyD6I3Co+u9e4GIdew4pUgpS9FcXlMQinSq0wMAaYYpdjp4WtuQ
         0kTwO4KlIG/mg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: ipq5332: add missing properties to the GPIO LED node
Date:   Thu,  7 Dec 2023 18:57:48 -0800
Message-ID: <170200426909.2871025.15697445467291685865.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231025-ipq5332-gpio-led-v1-1-0f0f52617648@quicinc.com>
References: <20231025-ipq5332-gpio-led-v1-1-0f0f52617648@quicinc.com>
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


On Wed, 25 Oct 2023 19:20:05 +0530, Kathiravan Thirumoorthy wrote:
> Add the color and function property to the GPIO LED node, which are
> missed out in the initial submission.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: ipq5332: add missing properties to the GPIO LED node
      commit: 63a021f52f69092f17d24707cd8e81f914f8d1e6

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
