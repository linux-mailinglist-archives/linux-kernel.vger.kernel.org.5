Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A39280A5E7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 15:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574032AbjLHOvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 09:51:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574023AbjLHOvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 09:51:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63867122
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 06:51:06 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECB29C433C9;
        Fri,  8 Dec 2023 14:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702047066;
        bh=SQpHakPT9JqzKdX2icL5N+lKtBj/wLSQWGlTEM4Dl7A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qWuyvLCMN/BsuaUXoYhoLQ5LVed9yAIqxRnRk0V8Gs9JshOFjGvoAW2flAPUo+Y/f
         maVAQdXVxMoGBeTzffSt/AM349OygJrC+pgOwyuUU8PotvgkPcTJSEIBRUu8qCJLVe
         rgJiFqYLQZMMCeyhQ9hft4s36cmaXgb0fOdqKZ7jO3EUnAUDq4PeixzALDybYQAYhL
         j6HNUwg0XANCoDA2o97C/3oppKo2SjsxxED0QTFYm8IjaG6NxGu4p2xC5L7QIoWav8
         xys6PERdD6Uf8MJOXB6EF8bm8aM/97eh7cZbHnF8uhYDse0IME3XADQ8JQXRz9GEPK
         9LNVxPHKrGOMA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Dang Huynh <danct12@riseup.net>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: (subset) [PATCH v2 0/4] Add PM8937 PMIC support
Date:   Fri,  8 Dec 2023 06:55:15 -0800
Message-ID: <170204733625.342318.3741380066572261384.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231121-pm8937-v2-0-b0171ab62075@riseup.net>
References: <20231121-pm8937-v2-0-b0171ab62075@riseup.net>
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


On Tue, 21 Nov 2023 12:34:58 +0700, Dang Huynh wrote:
> PM8937 is a power management IC. It is used in various boards with
> MSM8917, MSM8937, MSM8940 and APQ variants.
> 
> This patchset has been tested on Xiaomi Redmi 4X (MSM8940).
> 
> 

Applied, thanks!

[4/4] soc: qcom: socinfo: Add PM8937 Power IC
      commit: d50b5cb1a8f7db8ad2dc6a13f0cabedf7a7e1540

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
