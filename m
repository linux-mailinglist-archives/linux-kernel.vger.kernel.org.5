Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 193B27C546A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 14:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346895AbjJKMyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 08:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbjJKMyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 08:54:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41C09E
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:54:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F70DC433BD
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 12:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697028879;
        bh=lsXLuQurGnh4Z0akGPosK/CsIo+qnmnGl1yd/JhynMQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TJr4PxMfQ66iTpUsLi0t/XB2NNLOOVtPTsOuvyhUmXSF637kHZ/ag5bcrCmpsGnLw
         2zDvMx1av8zgYaUiFDcux3qv9N/T9Txx/q5UhM9NYjlHqncGDww1JGua9oNP4vw7vU
         F8DRzCDUBXADwLVeBXEJSMmUNLxUJKwNsNahkLLkH2M0zFyI2sZRRoF5gCbQCw86gQ
         fO7LytSB6utLlF8Sos6Z//qU3c9b1urxAhDKrm8vmSnCCFzjOPP6GLxYz38wVmggd7
         uoDgQbYeI5q3vOoJZItq1LMT3Bj+Mb2R4ntYJifdQFx7CrmJM0K5SeerDAWekaNoRP
         0A/JhtfjM/c+w==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so1930985a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:54:39 -0700 (PDT)
X-Gm-Message-State: AOJu0YyztRA03XyHWbvWLwwS38+lHv+zRRHA6BH5+i0DA9fS+UQQfJnc
        VGZ/7yEhwloXxDhMREORFNtvFwVXepOqAYsGS442og==
X-Google-Smtp-Source: AGHT+IHbEm3Uc2en9wMFmmEPBhW/KYWyTxzoEHjV+GnKE9YZ88khdvtKcTY7Q+g52u+n7nUhh4rPKmXMuT2NYqW9/gE=
X-Received: by 2002:a17:907:7246:b0:9a1:aaae:8207 with SMTP id
 ds6-20020a170907724600b009a1aaae8207mr14014040ejc.20.1697028877819; Wed, 11
 Oct 2023 05:54:37 -0700 (PDT)
MIME-Version: 1.0
References: <5725069.DvuYhMxLoT@kreacher> <f74a029d-39be-4deb-bc4f-a1bc1e401082@linaro.org>
In-Reply-To: <f74a029d-39be-4deb-bc4f-a1bc1e401082@linaro.org>
From:   Amit Kucheria <amitk@kernel.org>
Date:   Wed, 11 Oct 2023 18:24:26 +0530
X-Gmail-Original-Message-ID: <CAHLCerOYRm6_ZUbpBAxtRZ2e6O_1-w9k-FxfsMv7k-wkN1nG-Q@mail.gmail.com>
Message-ID: <CAHLCerOYRm6_ZUbpBAxtRZ2e6O_1-w9k-FxfsMv7k-wkN1nG-Q@mail.gmail.com>
Subject: Re: [PATCH v3] thermal: Remove Amit Kucheria from MAINTAINERS
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 7, 2023 at 6:21=E2=80=AFPM Daniel Lezcano <daniel.lezcano@linar=
o.org> wrote:
>
> On 07/10/2023 13:36, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Subject: [PATCH v2] thermal: Remove Amit Kucheria from MAINTAINERS
> >
> > Amit Kucheria has not been participating in kernel development in any
> > way or form for quite some time, so it is not useful to list him as a
> > designated reviewer for the thermal subsystem or as the thermal zone DT
> > binding maintainer.
> >
> > Remove him from the THERMAL entry in MAINTAINERS and list Daniel Lezcan=
o
> > as the new thermal zone DT binding maintainer.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
>
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Acked-by: Amit Kucheria <amitk@kernel.org>
