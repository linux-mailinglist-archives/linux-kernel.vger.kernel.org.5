Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6D5379D820
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 19:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237464AbjILRyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 13:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237342AbjILRyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 13:54:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A1B1FC0;
        Tue, 12 Sep 2023 10:53:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C540EC433CA;
        Tue, 12 Sep 2023 17:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694541236;
        bh=8Yjaumo8M/BOnRThpF0rGp6gTorTSUirAKyRPAduSJc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nzPUMMcy/mBrungOX+UZrdAUgaO/nyB6DQVxn8Sc6BONUh8BbkqRtbMHgYeXhj1QV
         3yKi6FyydiO0bxlpIEJQDFpWQX42KaSfS4sWet6HQ0GWSls7OQzqY9RhnAw0Rqf++b
         I8qeENcitawz9G1y0M/O+VkBaniCjNZ/N4TXxEACaIZ41w/G/H/1V3BMWPFSxQ1kpa
         dqG+9AsbM0A/X+39T/A0Irtv5hCNpYDzZgXUPcuUzms1FrkdxgTIr9LOdaRh9mTBmE
         gN2k/ZW9G8CJGMpHTaO4Sn+NKyHcJltlrVjC50W2BTPB4UWR0X8BwBzoKPVwUI1k2d
         5L4Yeq7jOdTLA==
Received: (nullmailer pid 992943 invoked by uid 1000);
        Tue, 12 Sep 2023 17:53:54 -0000
Date:   Tue, 12 Sep 2023 12:53:54 -0500
From:   Rob Herring <robh@kernel.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Robert Marko <robimarko@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH 5/6] dt-bindings: regulator: qcom,spmi: Document PMA8084
Message-ID: <169454123436.992887.15253313371626687800.robh@kernel.org>
References: <20230912-spmi-pm8909-v1-0-ba4b3bfaf87d@gerhold.net>
 <20230912-spmi-pm8909-v1-5-ba4b3bfaf87d@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912-spmi-pm8909-v1-5-ba4b3bfaf87d@gerhold.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 12 Sep 2023 09:49:53 +0200, Stephan Gerhold wrote:
> Document the qcom,pma8084-regulators compatible together with the
> necessary supply properties to allow interfacing via the hardware
> regulator registers directly via SPMI. This is mainly intended for
> debugging since the regulators are typically controlled via the RPM
> firmware (qcom,rpm-pma8084-regulators compatible).
> 
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
>  .../bindings/regulator/qcom,spmi-regulator.yaml    | 29 +++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

