Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA6976DD07
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 03:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjHCBKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 21:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbjHCBKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 21:10:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D713187;
        Wed,  2 Aug 2023 18:10:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF78861A17;
        Thu,  3 Aug 2023 01:10:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F424C433C7;
        Thu,  3 Aug 2023 01:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691025018;
        bh=PvrvK37FaEsaLjjz6nuh7mHpARoFCz1TcAgIQKS6LJA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IGBLr/o7QIYabUi4sk1e1+TsuH86dPdXH/RtViLcrAOqcujXwYM302vg2z549XudC
         h+V73wN62QM3r3Mrcc+VlxsRpBMwSuAfclW5PLxYtJLzdBl25FzyWp5so7sGjSIN2/
         YKC3Ne9I4Mfy0IaNVvhpvcwb6Lt98oFku7/QE+1i2OCL+C0vwu+2GLOsjL08R5rDgs
         Pd+NTEKTT8igb8KNNxLqH5ygzpRLDvJydwMqQjyi/RN3lxL93jRN9jGM2MQySlWxIb
         3nEdhjQ7IxzzFEJYeYEA3y2UPTyIEaRn21sHQpAwfybr0idSyApk7nspJo02BQkXc0
         QrjQemHzMzaUw==
Received: (nullmailer pid 1634744 invoked by uid 1000);
        Thu, 03 Aug 2023 01:10:16 -0000
Date:   Wed, 2 Aug 2023 19:10:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lee Jones <lee@kernel.org>
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
Message-ID: <20230803011016.GA1630536-robh@kernel.org>
References: <20230728001622.4938-1-quic_gurus@quicinc.com>
 <20230728075416.GC8175@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728075416.GC8175@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 08:54:16AM +0100, Lee Jones wrote:
> On Thu, 27 Jul 2023, Guru Das Srinagesh wrote:
> 
> > Clean up my email address as the codeaurora.org address is not used
> > anymore.
> > 
> > Signed-off-by: Guru Das Srinagesh <quic_gurus@quicinc.com>
> > ---
> >  Documentation/devicetree/bindings/extcon/qcom,pm8941-misc.yaml | 2 +-
> >  Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml         | 2 +-
> 
> 2 patches isn't exactly 'treewide'.
> 
> Anyway, since there are not dependencies between the changes, please
> separate them out, one per subsystem.

I'm happy to take these patches via the DT tree. No real advantage to 
creating more work to split up these trivial changes.

Rob
