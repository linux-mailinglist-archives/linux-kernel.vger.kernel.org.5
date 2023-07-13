Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A44217523CB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 15:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234769AbjGMNbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 09:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233731AbjGMNbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 09:31:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F952711;
        Thu, 13 Jul 2023 06:31:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82A0F61087;
        Thu, 13 Jul 2023 13:31:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CC52C433C7;
        Thu, 13 Jul 2023 13:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689255086;
        bh=kaxCDYwBzZYD/7jz9z7K9FFoWhGR1umaG7s9C5mESxc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y0vZKNnK037nGhBdt19LGZFAdRzBgIUfTyHDDOMaiutO4uvsYFtt5D5dS7BTBPgjl
         fv2sKa/rjg6lW05kF4bBI0Xo/I8Ww3Out86iQOZeC48OWJk7TPNBlR1gYT53l4uaVV
         zTkwe+gQyb6yFIDmpBnuNs4ka0m4KftwvdljDuFCWuRlsW0BFPhjvdvZw1+I+mZ7Ux
         bqHLdTYHpNtTfhaBJoNLhtQAYD+MKxUyOqKPBOO7BZHhRw35JfZ1Wq7j2wYS9VRyhn
         eTK2/SIwwwIbzoQs2IvziCRqRQntXVeiVt9XiC9xVqbhsYZ3xdTaC58+N7mqAt1/Rx
         kP+ZfhaOMa2IA==
Date:   Thu, 13 Jul 2023 14:31:19 +0100
From:   Lee Jones <lee@kernel.org>
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linus.walleij@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, sboyd@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 03/10] dt-bindings: mfd: Add compatible for pm7550ba
Message-ID: <20230713133119.GQ10768@google.com>
References: <1688395346-3126-1-git-send-email-quic_rohiagar@quicinc.com>
 <1688395346-3126-4-git-send-email-quic_rohiagar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1688395346-3126-4-git-send-email-quic_rohiagar@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Jul 2023, Rohit Agarwal wrote:

> Add compatible for pmic pm7550ba used in Snapdragon series.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> ---
>  Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks

-- 
Lee Jones [李琼斯]
