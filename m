Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B09879D81D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 19:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237465AbjILRx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 13:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237336AbjILRxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 13:53:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A342116;
        Tue, 12 Sep 2023 10:53:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59395C433C9;
        Tue, 12 Sep 2023 17:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694541191;
        bh=AcVbg2/ORoqtG5/izgRKHLtW2TP3tN828PkoZw7cwBM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GVpqbYpLkJCq/2q1NfsaL2KdUGVVCeZiu+vuOnMgyJwb1GF/Ri4YZ240Rrm/xZMiA
         WNx8dHoDgK50NGxTWuHqrnlcknjoF4irBrKkpIfGV7hCBUgDBsKXIckFfULBUOojM7
         m4W35YnWlElurNCYPp2M2DgPtPOZ8PrZhpxfL7T64OtSD/op/eUIgG/TtDRPDRg7E+
         15MLPiIT9Kfw13M6zcJuqblbkHtW4Ll2I3pHNZHN/euPC2hdf/A0fO0LuSGC/x74X+
         EEFAkM6UW5Pe3mD7RwxB0E11fO2yNoGVKL5V8J2UW3kvZBM1R97Alz3MZGMx0xmysi
         7o9TIwnXMG6WQ==
Received: (nullmailer pid 991958 invoked by uid 1000);
        Tue, 12 Sep 2023 17:53:09 -0000
Date:   Tue, 12 Sep 2023 12:53:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Robert Marko <robimarko@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/6] dt-bindings: regulator: qcom,spmi: Document PM8019
Message-ID: <169454118848.991891.11239428648860075374.robh@kernel.org>
References: <20230912-spmi-pm8909-v1-0-ba4b3bfaf87d@gerhold.net>
 <20230912-spmi-pm8909-v1-3-ba4b3bfaf87d@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912-spmi-pm8909-v1-3-ba4b3bfaf87d@gerhold.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 12 Sep 2023 09:49:51 +0200, Stephan Gerhold wrote:
> Document the qcom,pm8019-regulators compatible together with the
> necessary supply properties to allow interfacing via the hardware
> regulator registers directly via SPMI. This is mainly intended for
> debugging since the regulators are typically controlled via the RPM
> firmware (qcom,rpm-pm8019-regulators compatible).
> 
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
>  .../bindings/regulator/qcom,spmi-regulator.yaml      | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

