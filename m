Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C06C79D8AA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 20:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237372AbjILS3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 14:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232721AbjILS3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 14:29:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C6D10D8;
        Tue, 12 Sep 2023 11:29:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9D3BC433C7;
        Tue, 12 Sep 2023 18:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694543350;
        bh=PCBBmd2rNXdYvalQ81EoedbVyQS1gg/YJ45YkQpk9R8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h5lWbuDsz8fsbsQ9zdj4m+uoU7PwBXm5e9Vbhs+KCiZg6X060w5uyM3lUpJS7Z3vT
         ko7rp60/iuf1Y1CrxT+IUXY3qSg+06DByf+LUjgENAD2oggPkJYKZIdt7Q1swUW04h
         83y/GD1bothIes7zkBF7Izce/wFGMb6GJmFodUgiMf7zk+iP4y/gDLVbO6Ixfi5o27
         7wC/9zqDd2ytNDQtS0g1cP5OEcsiMSYR6wHw1zK6CC3E6JiktWd26ynEoHpRrMLuiz
         5cM+1C+ql85JTa1pyNPyMdXDIjx6LKY/yziHe/tkt9Zn/qNsnxEuIODMfGdThtRR6b
         uxffXapQ+rb7Q==
Received: (nullmailer pid 1164193 invoked by uid 1000);
        Tue, 12 Sep 2023 18:29:07 -0000
Date:   Tue, 12 Sep 2023 13:29:07 -0500
From:   Rob Herring <robh@kernel.org>
To:     Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>, devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 3/4] dt-bindings: cpufreq: qcom-nvmem: Document MSM8909
Message-ID: <169454334732.1164153.5118228878567772612.robh@kernel.org>
References: <20230912-msm8909-cpufreq-v1-0-767ce66b544b@kernkonzept.com>
 <20230912-msm8909-cpufreq-v1-3-767ce66b544b@kernkonzept.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912-msm8909-cpufreq-v1-3-767ce66b544b@kernkonzept.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 12 Sep 2023 11:40:17 +0200, Stephan Gerhold wrote:
> Document that MSM8909 is used with qcom-cpufreq-nvmem for voltage
> scaling and to restrict the maximum frequency based on the speedbin
> encoded in the nvmem cells.
> 
> Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
> ---
>  Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

