Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9040F7BC6E6
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 12:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343856AbjJGKpD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 7 Oct 2023 06:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343815AbjJGKpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 06:45:00 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5BAEA;
        Sat,  7 Oct 2023 03:44:59 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3af59a017a5so520914b6e.1;
        Sat, 07 Oct 2023 03:44:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696675498; x=1697280298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VXhc4AjiVWEhMnGIoyNOjXGEIVUwbZEwWnoHiLFbjX0=;
        b=ilMMd8G9ORFMvuZyVSd4lnr4CSkFz4qWYf3MrCUy9qP/nT/VevQ2g3yswrvSG9DPq6
         H/cVtyix+t/pRQsbwRAet36SMsKCVJR4SNLTJ5gS2GxqKapYmfmF2viN1OkSgztGsZpc
         IfFOlEfV/UNeo8sgfW74KAWkkF50sZIlKQF/LhX97igzKNBdfyKN/WUsqUZiGCALOd0B
         aXSWXCVRf0PtZT4VXzKfaSg9dmx5+O0Ne7rEBd9KCyS/jMeVgkDINaGJv1RDNKOo1+6P
         r0U2SZuMGESTbXtkEeztwpl3Ne7pXawGDvmYaVR3KzCVYW/tqHy1KYm4hMq95FehkV3v
         ypfQ==
X-Gm-Message-State: AOJu0Yz4yIf0QDUBifjfgWfDs/bK99g1jMdU/S+SRGSelfEEfRrzLo9k
        6At+x8pMJhadfp4rnMi6iLKtQW8WuV25rhLMrWc=
X-Google-Smtp-Source: AGHT+IFRS4P43ZIQse0aIU83wX0h2pT4KbfEj1/GBsYLcEBcde33BDz2cby3K6bpc13NeyU0HatTVwRle8efMP7f4PU=
X-Received: by 2002:a05:6830:490e:b0:6c4:7516:f2cf with SMTP id
 eq14-20020a056830490e00b006c47516f2cfmr13156936otb.2.1696675497907; Sat, 07
 Oct 2023 03:44:57 -0700 (PDT)
MIME-Version: 1.0
References: <5716404.DvuYhMxLoT@kreacher> <f0daa859-f9eb-4631-b2f9-6ee3ce5b691f@linaro.org>
 <9833cebf-e951-47c6-97b7-458ae1a5b747@linaro.org> <908fc8d6-10d2-51f9-fd70-171522c7e67d@arm.com>
 <ca4b87ea-7b59-4465-ba29-3280e82149e4@linaro.org>
In-Reply-To: <ca4b87ea-7b59-4465-ba29-3280e82149e4@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 7 Oct 2023 12:44:46 +0200
Message-ID: <CAJZ5v0jXPN4KEfZsFO0yU76jUVKLYFnp8-ib2tkcOvc1R+k0eg@mail.gmail.com>
Subject: Re: [PATCH v1] thermal: Remove Amit Kucheria from MAINTAINERS
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Lukasz Luba <lukasz.luba@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Amit Kucheria <amitk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 6, 2023 at 11:44 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 06/10/2023 15:48, Lukasz Luba wrote:
> >
> >
> > On 10/6/23 14:43, Krzysztof Kozlowski wrote:
> >> On 06/10/2023 15:43, Krzysztof Kozlowski wrote:
> >>> On 06/10/2023 13:21, Rafael J. Wysocki wrote:
> >>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>>>
> >>>> Amit Kucheria has not been participating in kernel development in any
> >>>> way or form for quite some time, so it is not useful to list him as a
> >>>> designated reviewer for the thermal subsystem or as the maintainer of
> >>>> the thermal zone device bindings.
> >>>>
> >>>> Remove him from those two places accordingly.
> >>>>
> >>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>>> ---
> >>>>   Documentation/devicetree/bindings/thermal/thermal-zones.yaml |
> >>>> 3 ---
> >>>
> >>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>
> >> and unAcked. We need a maintainer for the bindings. Someone else from
> >> thermal?
> >>
> >
> > I'm going to handle the review in thermal subsystem. Although,
> > I forgot about this 'binding' thing...
> >
> > Daniel, what do you think?
>
> I can handle the bindings, I rewrote the thermal-of code and worked with
> Amit on the txt to yaml conversion.

Sounds good!

I'll send a v3 of the patch then with this change included, please ACK it.
