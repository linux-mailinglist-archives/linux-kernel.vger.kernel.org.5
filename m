Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0B4C752AD4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 21:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjGMTS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 15:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231923AbjGMTSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 15:18:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D5B1993;
        Thu, 13 Jul 2023 12:18:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD10B61B3B;
        Thu, 13 Jul 2023 19:18:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4970DC433C7;
        Thu, 13 Jul 2023 19:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689275926;
        bh=TSJdqumq1fGLHFbMKLCBH8IWA/Z88gRdY2/S009y/SQ=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=I8QoNcscyPr393IPiONHeB+Jn8tTsOgvJImpQbNsb5s/C5i436GP0DT378wk9c0nf
         p29S+RZQwO+jjEgTcrnmHs2nTsmP5eKgF9FTHixosy4pa/pHVKbpkAsKBKgt5xjfcF
         P3fHubrMzYZ8i1wScKc/mW12bz1yC9wX6qQda1wkL6s9QnpcZ3Opy6fafCnUIPSITj
         YWnIH+1+t50xXcZo1qPv3vQ4Jj1E27Cknke8AWZItSKYIyS6RVdNcZkqIOJfJXHJ/Z
         T34uV3ThKvrnqutO8g7g48Y4OudcREjxlVsYSU5YvlVhcTqinZjpvgQrvIFzsrU0Je
         GOTq2nz0cQTYw==
From:   Lee Jones <lee@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?utf-8?q?Fern=C3=A1ndez_Rojas?= <noltari@gmail.com>,
        Jonas Gorski <jonas.gorski@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230713065040.7968-1-krzysztof.kozlowski@linaro.org>
References: <20230713065040.7968-1-krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [RESEND PATCH] dt-bindings: mfd: brcm: drop unneeded
 quotes and use absolute /schemas path
Message-Id: <168927592265.1059976.2393967694279079566.b4-ty@kernel.org>
Date:   Thu, 13 Jul 2023 20:18:42 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 13 Jul 2023 08:50:40 +0200, Krzysztof Kozlowski wrote:
> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.  Also absolute path
> starting with /schemas is preferred.
> 
> 

Applied, thanks!

[1/1] dt-bindings: mfd: brcm: drop unneeded quotes and use absolute /schemas path
      commit: 113f9d8b863079e37c038092898c5deabc08f1cb

Best regards,
-- 
Lee Jones <lee@kernel.org>

