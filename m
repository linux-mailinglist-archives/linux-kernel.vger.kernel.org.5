Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 544A27BBC2F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 17:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232907AbjJFPya convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 6 Oct 2023 11:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232876AbjJFPy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 11:54:28 -0400
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6FCB6;
        Fri,  6 Oct 2023 08:54:27 -0700 (PDT)
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-57b83ff7654so153263eaf.1;
        Fri, 06 Oct 2023 08:54:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696607666; x=1697212466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qyVUD+jtO3xjKZijmbi69I8h0KpD3PVUx5fopCCsA34=;
        b=Cs8sBu7oNCAza03v36rrmlmVZb7ASF+ZwCGI4KpAgxRmwr35KRaNS/BNPF5K1ldsoF
         jks4ZR1AOwMbrzQctRiAS0xIp8UXQivYldSTI+w/hTtgwPpiMnQb/WsdB/ZXVdZeAMnu
         HT4dCqKw5Oye6a1qSKF+9b0AgCYC5jQd5Guiyw05A4LJ+ZVIY+vntqKIChR06yeqMW5B
         jpWVztHlc0cqqaOUDInMTt9kBMxE/oNtOJxrZhOiqLtxQs9XinJM8rT2p6zoFUx3C7yx
         +ESjHhMuK7KL2uuaZBaeYQnRwqopheUX0yBQe4QTTN8HIxReS8YL1lQI9Agczufkmb4s
         nBYg==
X-Gm-Message-State: AOJu0Ywf9p+PedjYCqi7jXBRVl0m+WiWade4RvxCq6Z4OuXHh5s3aa6b
        5KfY9I1ZAWdtQEU6l3Uca7Keg5mhlwkBpFm6s2w=
X-Google-Smtp-Source: AGHT+IFWASLRCNFIE/UGk9jOTbyA2SJBiczvi635c3ueLXQnQ5y0w5AY3AsHaewjdL00Z0TXAa6dEyI3BhB4/hf8iaM=
X-Received: by 2002:a4a:b588:0:b0:578:c2af:45b5 with SMTP id
 t8-20020a4ab588000000b00578c2af45b5mr8191603ooo.0.1696607665758; Fri, 06 Oct
 2023 08:54:25 -0700 (PDT)
MIME-Version: 1.0
References: <2702191.mvXUDI8C0e@kreacher> <20231006-earthly-equal-dd5d82312add@spud>
In-Reply-To: <20231006-earthly-equal-dd5d82312add@spud>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 6 Oct 2023 17:54:14 +0200
Message-ID: <CAJZ5v0g56dS0xV4m+WUCZPU3aU_5JNP52ex6ebTQmNh7hjVacA@mail.gmail.com>
Subject: Re: [PATCH v2] thermal: Remove Amit Kucheria from MAINTAINERS
To:     Conor Dooley <conor@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>,
        Amit Kucheria <amitk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 6, 2023 at 5:46 PM Conor Dooley <conor@kernel.org> wrote:
>
> On Fri, Oct 06, 2023 at 05:04:42PM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Amit Kucheria has not been participating in kernel development in any
> > way or form for quite some time, so it is not useful to list him as a
> > designated reviewer for the thermal subsystem.
> >
> > Remove him from the THERMAL entry in MAINTAINERS.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > v1 -> v2: Drop the DT binding change
> >
> > I'm really not inclined to fight over stuff that doesn't make any sense to me.
>
> I don't understand what you mean by this. All that was required was
> putting __someone__ down as a maintainer in the dt-binding, as Rob's bot
> told you:
> https://lore.kernel.org/linux-devicetree/CAJZ5v0gwvo_CriNwz_g-oQ8EZUqdp4ymiuamU-KkrmQ87RhZyA@mail.gmail.com/T/#m56a9b1616477566e2976044c11b58dccbd3be0fb

And this doesn't make sense, because I don't know who to put in there
and the current record is clearly stale.
