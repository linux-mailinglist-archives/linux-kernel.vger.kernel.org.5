Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC377BBBD2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 17:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbjJFPgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 11:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232820AbjJFPgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 11:36:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15EEBA6;
        Fri,  6 Oct 2023 08:36:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1022C433C7;
        Fri,  6 Oct 2023 15:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696606591;
        bh=XKrlh52/xCv6WSC2L6XJZQfYHZD/gUFZWaCEyBCpEeo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fftnpSMSsBB+5lYOQaTeKbNLcppQVgrw6C/dOra/J6SkBQDqR7jjFK4qduY8ey+bd
         60DFvMA0gS3sBQAyIjs5cenGjskaK9VMSR7YAxZ1XdEv0Nkpb/hihs/0Juyx8uNEeQ
         tvdfVhufp8x6LurbQ8hN5g8JPgHxlVJFYdle15WA0B7amLYG7Qe6OAq07mTU37deUt
         YU+k0rZTaMzncVwgW5f3eWkrqaerAzFSQ4f5gzYZgavYnpU8tgVsSDx+TSmNdN+wb6
         LtZaE7AvWv6GevJyqzmtS2JKxqKeczpkY/sfJT+nkIkMYJ0LUSOnJxFth11ca+Wy1l
         z454ub3nOzf4A==
Received: (nullmailer pid 3978856 invoked by uid 1000);
        Fri, 06 Oct 2023 15:36:21 -0000
Date:   Fri, 6 Oct 2023 10:36:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sridharan S N <quic_sridsn@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        conor+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, robh+dt@kernel.org, konrad.dybcio@linaro.org
Subject: Re: [PATCH] dt-bindings: arm: qcom: drop the IPQ board types
Message-ID: <169660658107.3978799.1662058094270868857.robh@kernel.org>
References: <20230927093130.4098385-1-quic_sridsn@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927093130.4098385-1-quic_sridsn@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 27 Sep 2023 15:01:30 +0530, Sridharan S N wrote:
> IPQ bootloaders do not need these information to select the
> the DTB blob. So dropping the board names from board section.
> 
> Signed-off-by: Sridharan S N <quic_sridsn@quicinc.com>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 14 --------------
>  1 file changed, 14 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

