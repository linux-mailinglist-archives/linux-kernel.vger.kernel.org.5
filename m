Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2E797BBB0B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 17:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbjJFPAu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 6 Oct 2023 11:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232677AbjJFPAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 11:00:48 -0400
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C244CF;
        Fri,  6 Oct 2023 08:00:48 -0700 (PDT)
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-57f137dffa5so46967eaf.1;
        Fri, 06 Oct 2023 08:00:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696604447; x=1697209247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BVW6wgbrWAJ5GiW16+xdHyZa95+t36ycCSLL2Z8ofcU=;
        b=AkdM9Wox8DYp5c3+8JsuIQk77cfLSnIS8DwHj8/QkZ1LbuM2eI5OddlJlDQRfg1KXK
         74fv2rqESR1PHhGbPEMsOri3AUoP18vvW29SPLab+1nbZDirhoMMF368VbpAHQ1/jKLg
         X9G20XIFWN30HA4Y2vvkVhfnLkvRjL/bSegPsQeHw+9Us80VjxifBS3B+L0PrrnTqDuj
         1M3AL+ZQu6OWmJPE7cayrSy7XFSQ1T1gsNEdlyKA5yVy4NB3zx6L1z3eQhxwR61AmhVv
         oAXDcoVYZ9nSygi7ZHQTgVUhYADuUOmL+mkqjZi2BnVQeiusm7wWy3rEOvGZFbbJ+taF
         RNKg==
X-Gm-Message-State: AOJu0Yw/jQsWYoFqTjQ7DGABvjOZicTiv8yu0QSk6YebFgYQnrR7+xuD
        iCB4QCu0rUWx5MNqJuTvpHAAGObvr37tbGgcDNQ=
X-Google-Smtp-Source: AGHT+IGQmbQgf/J1sJdaBVSblWl8mKz+qb6tdmwzWZSMxt2N9lbMFTu3gS0mZNUQZvrWqFmcuBbGxzZXRtiishr6lRk=
X-Received: by 2002:a4a:d097:0:b0:57b:7e31:c12 with SMTP id
 i23-20020a4ad097000000b0057b7e310c12mr8503572oor.1.1696604447268; Fri, 06 Oct
 2023 08:00:47 -0700 (PDT)
MIME-Version: 1.0
References: <5716404.DvuYhMxLoT@kreacher> <f0daa859-f9eb-4631-b2f9-6ee3ce5b691f@linaro.org>
 <9833cebf-e951-47c6-97b7-458ae1a5b747@linaro.org>
In-Reply-To: <9833cebf-e951-47c6-97b7-458ae1a5b747@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 6 Oct 2023 17:00:35 +0200
Message-ID: <CAJZ5v0gwvo_CriNwz_g-oQ8EZUqdp4ymiuamU-KkrmQ87RhZyA@mail.gmail.com>
Subject: Re: [PATCH v1] thermal: Remove Amit Kucheria from MAINTAINERS
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

On Fri, Oct 6, 2023 at 3:44 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 06/10/2023 15:43, Krzysztof Kozlowski wrote:
> > On 06/10/2023 13:21, Rafael J. Wysocki wrote:
> >> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>
> >> Amit Kucheria has not been participating in kernel development in any
> >> way or form for quite some time, so it is not useful to list him as a
> >> designated reviewer for the thermal subsystem or as the maintainer of
> >> the thermal zone device bindings.
> >>
> >> Remove him from those two places accordingly.
> >>
> >> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >> ---
> >>  Documentation/devicetree/bindings/thermal/thermal-zones.yaml |    3 ---
> >
> > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> and unAcked. We need a maintainer for the bindings.

Well, yes, we do, but how useful is it to hold on to the stale record?

Surely, it doesn't help anyone.

> Someone else from thermal?
