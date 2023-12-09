Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1992680B566
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 18:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjLIRIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 12:08:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjLIRIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 12:08:04 -0500
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A79C121
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 09:08:09 -0800 (PST)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1702141687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kh1DA/v53PnINd03bhNbVOefrP+VfCi294Z535BlDZI=;
        b=RYfj0lvHNRaBwQfdlORTXx0KnsieEEfGpzyIPdQXwLYHoKmRk/H0gtBM6ZvMaEHdqsIaoP
        +IxStqaO6kA/InJxImrZzgf4UuwlHMGlCRpDXUf99Rf9eGRBriufyPCY4Lf/X3JEjA2GRu
        TVvPguajcohi/3GBjnBqSPWJHgVljQM=
Date:   Sat, 09 Dec 2023 17:08:05 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Konstantin Ryabitsev" <konstantin.ryabitsev@linux.dev>
Message-ID: <63e4c6098fdf5b7995dab74b415d55d32f757b5c@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v7 0/2] Resolve MPM register space situation
To:     "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Andy Gross" <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        "Marc Zyngier" <maz@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Shawn Guo" <shawn.guo@linaro.org>,
        "Conor Dooley" <conor+dt@kernel.org>
Cc:     "Marijn Suijten" <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
In-Reply-To: <1c99bb49-51e9-458e-acef-a0615dca95ce@linaro.org>
References: <1c99bb49-51e9-458e-acef-a0615dca95ce@linaro.org>
 <20230328-topic-msgram_mpm-v7-0-6ee2bfeaac2c@linaro.org> <87il58sr12.ffs@tglx>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

December 9, 2023 at 9:00 AM, "Konrad Dybcio" <konrad.dybcio@linaro.org> w=
rote:
> >  Signed-off-by on the cover letter is completely meaningless.
>=20
>=20Yes, I realize that. Blame b4.

It's not -- some subsystems use cover letters as merge commits.

-K
