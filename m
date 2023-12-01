Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEC0E800734
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 10:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378024AbjLAJg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 04:36:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjLAJg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 04:36:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B06F2
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 01:36:33 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80884C433C9;
        Fri,  1 Dec 2023 09:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701423392;
        bh=lyFbPGRwQF1Mz17lpmdyRYtxKbxhA1kFc+edIHz2ihE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d7wgLDbiQM1zMyqvDcLJBY6Cy0dbiti3Vv6NX+jY7ZYRcQ5raQNCGhPiR7mOsSl4a
         LJqeEhy/kDOATK+6fQkx2RnyyPqsjTi3j6bfmG/vt5caRJeDxsLKGQPGsVlLAKUn7a
         hPzkpSGrYsok+1ry2v4zVCn4Y0wZXTPo4xC8eRgGUEEjNcZa4COBLdSUOTBO2tXD6p
         ovsrTCAVMe5MM0a6tJZPGgusDtJJwAAa1T8X/wl0uCe+cH9Qy8nutpp8STEe1on/Q7
         FMe0MLphV3CfN/kym5qNz1lqCm2G4XPHNEV6Gs5k6zt6Oj0CgYuOuXKjAZiCgSjrnr
         SuaFPkO1VB5zA==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan@kernel.org>)
        id 1r8zxL-0003HC-2D;
        Fri, 01 Dec 2023 10:37:07 +0100
Date:   Fri, 1 Dec 2023 10:37:07 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>, Lee Jones <lee@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 4/4] dt-bindings: mfd: pm8008: fix example node names
Message-ID: <ZWmpQzkxFvAMURJ7@hovoldconsulting.com>
References: <20231130172547.12555-1-johan+linaro@kernel.org>
 <20231130172547.12555-5-johan+linaro@kernel.org>
 <9e59c5b7-ff37-47f1-aadc-3e33c55c1715@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e59c5b7-ff37-47f1-aadc-3e33c55c1715@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 09:35:30AM +0100, Krzysztof Kozlowski wrote:
> On 30/11/2023 18:25, Johan Hovold wrote:
> > Devicetree node names should be generic; fix up the pm8008 binding
> > example accordingly.
> > 
> > Fixes: b0572a9b2397 ("dt-bindings: mfd: pm8008: Add bindings")
> 
> No, there is no bug here. The generic node names rule is just a style
> issue, not a bug. We have never marked these as bugs even in DTS where
> they matter. Here, it is an example, so it would not matter anyway.

Here I agree with you, this is just a cleanup.

Johan
