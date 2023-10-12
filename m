Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57EA7C6A6D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 12:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343641AbjJLKGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 06:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235611AbjJLKGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 06:06:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29209D;
        Thu, 12 Oct 2023 03:06:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6205C43395;
        Thu, 12 Oct 2023 10:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697105176;
        bh=nmE5kc1sWWdzu/BYiwDppTah4huYcrYJ4W9pGYBd9Rk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=cEf14eEfZ/wy59/GN+5vbPpeQdrZKRo/gut2my2Vuw+1OoCYdnlyigpqDts87N6Yo
         U0/08E4II/oKHjMDDc5Iu0FUJAtzGfBgqclA+kqyHtsI4pBKmdKfqGWGcSbKm/62tA
         AE8atHvjbCMeMu4YH2Cj1gXyUlJSzEGJs899OX/A/bwpdZWop0G1S/dATQN6xagUHJ
         v7a0Oyn67oygTunqC9cqaPsaT43MFo2yZTDz4793bpeTx4e8U61iYyA16xNNqvW3JZ
         9vTmNE17Jn/cb6k88GgDDOh/dcUooslTKvE0qQukVgthz4ZY6jKW3HGt0eJXZNbA6u
         /v0SqjuTmqqEA==
From:   Lee Jones <lee@kernel.org>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        thierry.reding@gmail.com, ndesaulniers@google.com, trix@redhat.com,
        baruch@tkos.co.il, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Devi Priya <quic_devipriy@quicinc.com>
Cc:     linux-pwm@vger.kernel.org, u.kleine-koenig@pengutronix.de,
        nathan@kernel.org
In-Reply-To: <20231005160550.2423075-4-quic_devipriy@quicinc.com>
References: <20231005160550.2423075-1-quic_devipriy@quicinc.com>
 <20231005160550.2423075-4-quic_devipriy@quicinc.com>
Subject: Re: (subset) [PATCH V15 3/4] dt-bindings: mfd: qcom,tcsr: Add
 simple-mfd support for IPQ6018
Message-Id: <169710517252.1166696.13811645504228005200.b4-ty@kernel.org>
Date:   Thu, 12 Oct 2023 11:06:12 +0100
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

On Thu, 05 Oct 2023 21:35:49 +0530, Devi Priya wrote:
> Update the binding to include pwm as the child node to TCSR block and
> add simple-mfd support for IPQ6018.
> 
> 

Applied, thanks!

[3/4] dt-bindings: mfd: qcom,tcsr: Add simple-mfd support for IPQ6018
      commit: b4a32d218d424b81a58fbd419e1114b1c1f76168

--
Lee Jones [李琼斯]

