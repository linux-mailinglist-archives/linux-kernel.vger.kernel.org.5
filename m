Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAD1777D179
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 20:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238652AbjHOSE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 14:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238416AbjHOSEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 14:04:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EAA41987;
        Tue, 15 Aug 2023 11:04:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3982861309;
        Tue, 15 Aug 2023 18:04:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D12DC433C9;
        Tue, 15 Aug 2023 18:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692122651;
        bh=mzbNzne3PD1b7Z60xa5BSWREMcguu9Lbh3k0qDDEqnI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TFxdue8orHKEsUJoqRmvAkg7i1FWDzK3aT5o1una/QIlGBbxpoRPQMz48jitc78la
         jqPPzbnjmO+eEdnclI/4Hag3At/rhrOaZycktuADX3S7E1le7pMT/++mMHEKaNiiNN
         40ESLPG1GqKGuEiU3wjOWj6iQtVE93MMmXcvblFZnbVTKE4TxqW+wYaf6oUx7PDIxH
         fuy08mqTdZ/q0snWUmLARyyh/WjC2Lt/gTXQ82XhUutsTvtcBBBAt6onua7HsDt/iu
         xCn3RmqpmBlUKQvm5stmJUeLx192DpJubKU3tWq5IpnF9x/aWRGLteXLmEAVAZo06B
         bYLRxby9C4xwA==
Date:   Tue, 15 Aug 2023 19:04:05 +0100
From:   Lee Jones <lee@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] treewide: Update Guru Das Srinagesh's email address
Message-ID: <20230815180405.GG648357@google.com>
References: <20230728001622.4938-1-quic_gurus@quicinc.com>
 <20230728075416.GC8175@google.com>
 <20230803011016.GA1630536-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230803011016.GA1630536-robh@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Aug 2023, Rob Herring wrote:

> On Fri, Jul 28, 2023 at 08:54:16AM +0100, Lee Jones wrote:
> > On Thu, 27 Jul 2023, Guru Das Srinagesh wrote:
> > 
> > > Clean up my email address as the codeaurora.org address is not used
> > > anymore.
> > > 
> > > Signed-off-by: Guru Das Srinagesh <quic_gurus@quicinc.com>
> > > ---
> > >  Documentation/devicetree/bindings/extcon/qcom,pm8941-misc.yaml | 2 +-
> > >  Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml         | 2 +-
> > 
> > 2 patches isn't exactly 'treewide'.
> > 
> > Anyway, since there are not dependencies between the changes, please
> > separate them out, one per subsystem.
> 
> I'm happy to take these patches via the DT tree. No real advantage to 
> creating more work to split up these trivial changes.

Sounds good.

-- 
Lee Jones [李琼斯]
