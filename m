Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 033E87A7CE2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 14:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235183AbjITMF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 08:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235203AbjITMEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 08:04:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BFE393;
        Wed, 20 Sep 2023 05:04:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C8E2C433C9;
        Wed, 20 Sep 2023 12:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695211480;
        bh=RgqfN1Xfu93qH4Xs8kjd1SVTw5FJiMEsbdBE8cSzoSw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=JIPB8+8SaGhnOnwhY5AOQ1YKEJgLdk5rqXNB4YBIIpwK+6qTfGr7Q2XxUPu5J3bxf
         g2gWiOvBZmidtRyKP3b7v9F74QTfHCQINVJlSueaWTRoTimYE0kpwfhf2Fr7KvMGLk
         zEezT+tEGiGROhnuLkFkGTWOZzP4q04xSQN8H1qiYWUilr20cuO0pO3GUwz5Eu5q8O
         e1vC8NakXuhWFkcz7xEm0nLqSdc4oTRYxVGO9uImxin2wCbuXAEbOA9spRzt6FKW32
         JZ9TdZvNVTZoOXgmUfJX1RQLdtuvjRbSihHdOH6xy+GUjTsUpNgXO6wPJsLauYDTAS
         Iwhk6XfgEzIlA==
From:   Lee Jones <lee@kernel.org>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, tglx@linutronix.de, maz@kernel.org,
        lee@kernel.org, Tengfei Fan <quic_tengfan@quicinc.com>
Cc:     robimarko@gmail.com, quic_gurus@quicinc.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_tsoni@quicinc.com,
        quic_shashim@quicinc.com, quic_kaushalk@quicinc.com,
        quic_tdas@quicinc.com, quic_tingweiz@quicinc.com,
        quic_aiquny@quicinc.com, kernel@quicinc.com,
        quic_bjorande@quicinc.com
In-Reply-To: <20230908065847.28382-3-quic_tengfan@quicinc.com>
References: <20230908065847.28382-1-quic_tengfan@quicinc.com>
 <20230908065847.28382-3-quic_tengfan@quicinc.com>
Subject: Re: (subset) [PATCH 2/6] dt-bindings: mfd: qcom,tcsr: Add
 compatible for sm4450
Message-Id: <169521147588.3404980.18311458594014218511.b4-ty@kernel.org>
Date:   Wed, 20 Sep 2023 13:04:35 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 08 Sep 2023 14:58:43 +0800, Tengfei Fan wrote:
> Document the qcom,sm4450-tcsr compatible.
> 
> 

Applied, thanks!

[2/6] dt-bindings: mfd: qcom,tcsr: Add compatible for sm4450
      commit: 961c8e9cffce3bcbea982b609fd3df1913c9b905

--
Lee Jones [李琼斯]

