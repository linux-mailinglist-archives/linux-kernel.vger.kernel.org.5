Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE4C87ABAAA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 22:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjIVUuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 16:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjIVUud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 16:50:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576C91A2;
        Fri, 22 Sep 2023 13:50:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45085C433C7;
        Fri, 22 Sep 2023 20:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695415826;
        bh=8rUQPVnfBZ8nP+opU6DTtF/9h/0Y3eo/+O/9HxRH5wE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uV4w3zy8Ixj9BOX7Sc6mk0f8Opy6CAAoMdR0lguNgOWPqPzTpJjnJsObzg0NBlPpw
         5aA1K+y8AFcnFCTzfUwu1wxG4513oPJeNZ08bndBhLu7sbsttyltqabFz795u7fvwx
         MI70lspZm3m4M0IJ21M9YdjmKQZfmErXdH0sHN/lr+5lltm6iBu47CwaIdZmwE0MX4
         Ts/JYCPNuGsyJWe8z4d0mYZHlCcMRDBsNcqg9kAJLtO9JA2dhH8JVjIS5/11G5KcwL
         qYR0wCFoZ4vEJEp323lTJd8Krh2tsYFVPkl0OhYKBFzgj7V1QV6LErk7bHgfVye9X/
         hg1ez4SEp4jBg==
Received: (nullmailer pid 3556203 invoked by uid 1000);
        Fri, 22 Sep 2023 20:50:23 -0000
Date:   Fri, 22 Sep 2023 15:50:23 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sricharan R <srichara@win-platform-upstream01.qualcomm.com>
Cc:     rafael@kernel.org, quic_srichara@quicinc.com,
        linux-kernel@vger.kernel.org, dmitry.baryshkov@linaro.org,
        linux-pm@vger.kernel.org, srinivas.kandagatla@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andersson@kernel.org, thara.gopinath@gmail.com,
        konrad.dybcio@linaro.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski@linaro.org, linux-arm-msm@vger.kernel.org,
        agross@kernel.org, conor+dt@kernel.org, daniel.lezcano@linaro.org
Subject: Re: [PATCH V3 1/4] dt-bindings: thermal: qcom-tsens: Add ipq5018
 compatible
Message-ID: <169541580075.3555585.17615922669140216464.robh@kernel.org>
References: <20230922115116.2748804-1-srichara@win-platform-upstream01.qualcomm.com>
 <20230922115116.2748804-2-srichara@win-platform-upstream01.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922115116.2748804-2-srichara@win-platform-upstream01.qualcomm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 22 Sep 2023 17:21:13 +0530, Sricharan R wrote:
> From: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> 
> IPQ5018 has tsens v1.0 block with 4 sensors and 1 interrupt.
> 
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> ---
>  [v3] Added the tsens-ipq5018 as  new binding without rpm
> 
>  Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

