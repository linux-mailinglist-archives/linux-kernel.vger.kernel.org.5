Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B26C57CE83C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 21:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbjJRTx7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 18 Oct 2023 15:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjJRTx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 15:53:57 -0400
Received: from smtprelay05.ispgateway.de (smtprelay05.ispgateway.de [80.67.31.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F379AB;
        Wed, 18 Oct 2023 12:53:54 -0700 (PDT)
Received: from [92.206.139.21] (helo=note-book.lan)
        by smtprelay05.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96.1)
        (envelope-from <git@apitzsch.eu>)
        id 1qtCc3-00015F-2W;
        Wed, 18 Oct 2023 21:53:51 +0200
Message-ID: <11c55f82ec95f66f8b9381bf8a1a3b273ae986ab.camel@apitzsch.eu>
Subject: Re: [PATCH] arm64: dts: qcom: msm8939-longcheer-l9100: Add
 proximity-near-level
From:   =?ISO-8859-1?Q?Andr=E9?= Apitzsch <git@apitzsch.eu>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Date:   Wed, 18 Oct 2023 21:53:49 +0200
In-Reply-To: <a640a6c2-5b5c-48a5-9680-bec9514bd068@linaro.org>
References: <20231016-bqm5_prox-v1-1-2acdc732be9d@apitzsch.eu>
         <3aede886-3219-4b9f-a44d-0c414979c260@linaro.org>
         <65214451e02a38032e9fc6ac4cff185c6b2b5fc8.camel@apitzsch.eu>
         <a640a6c2-5b5c-48a5-9680-bec9514bd068@linaro.org>
Autocrypt: addr=git@apitzsch.eu; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.50.0 
MIME-Version: 1.0
X-Df-Sender: YW5kcmVAYXBpdHpzY2guZXU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, dem 18.10.2023 um 10:32 +0200 schrieb Konrad Dybcio:
> 
> 
> On 10/17/23 22:03, André Apitzsch wrote:
> > Am Dienstag, dem 17.10.2023 um 18:25 +0200 schrieb Konrad Dybcio:
> > > 
> > > 
> > > On 10/16/23 22:18, André Apitzsch wrote:
> > > > Consider an object near to the sensor when their distance is
> > > > about
> > > > 4 cm
> > > > or below.
> > > > 
> > > > Signed-off-by: André Apitzsch <git@apitzsch.eu>
> > > > ---
> > > Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > > 
> > > Out of interest, what is it set to by default?
> > > 
> > > Konrad
> > 
> > The default value is 0.
> That much I could guess :) I was wondering if it meant more like "it
> can detect movement from 1km away" or "disabled"
> 
> Konrad

I doubt that this sensor can detect anything from a distance of 50cm.

The values returned by the sensor are all non-negative, i.e. zero means
something like "disabled" as every raw proximity value would be
considered 'near' to the sensor according to the description in
iio/common.yaml.

André
