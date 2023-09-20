Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D53887A7156
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 05:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232635AbjITD4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 23:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232688AbjITDzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 23:55:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120F6B6;
        Tue, 19 Sep 2023 20:55:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC651C433C8;
        Wed, 20 Sep 2023 03:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695182108;
        bh=KLd/KTuYcUQ+62+oF51ABS8/yjh5Boe6tRWlpvMIzCg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kyf3Q1HmELPksD9KQVp8/G/536tKmm+xgFkGcwsJE1cw4HROmw2cTG50zTS2kCINl
         G8mnEMf5IBenh1Bl1QzaZxsinSd7KB2yxBJ95JzdoAKVnYmZP8Luyae2t0ypYN/YPN
         TK9vS4avKL4yC7RwSoQ3plv+htNfrU7SSpHzaVzSZwrVU1S+nZ0T+ffK6yQ7ti40Vz
         vDghR0iSnQbWqUdE0+8HIQ5+ntx6pouauqSGU6XanOfR4OhxOWeL+FTT2locjWjSAt
         4u5YcFWluXNrIab0sLez0xG8DSBWvh2cDuAbuknmfrbst4om/86n11iSdkxDzutEHg
         6KudLL6EfefMQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
Cc:     dianders@chromium.org, Andy Gross <agross@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v6 0/2] Add no-esim sku for sc7180-lazor family and new board version for audio codec ALC5682i-VS
Date:   Tue, 19 Sep 2023 20:58:59 -0700
Message-ID: <169518233715.1055386.9590552786770708093.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230823071306.131373-1-sheng-liang.pan@quanta.corp-partner.google.com>
References: <20230823071306.131373-1-sheng-liang.pan@quanta.corp-partner.google.com>
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


On Wed, 23 Aug 2023 15:13:04 +0800, Sheng-Liang Pan wrote:
> Changes in v6:
> - commit update, add dependent patch link
> - remove unnecessary symbol
> - sort out the order of properties
> 
> Changes in v5:
> - rebased on patch moving rt5682s to a fragment
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: arm: qcom: add sc7180-lazor board bindings
      commit: 5aca91ec55393b8829978b12062d658de0491f78
[2/2] arm64: dts: qcom: sc7180: Add sku_id and board id for lazor/limozeen
      commit: b8d34535a04c11b92a687c31a352c123ba21e22b

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
