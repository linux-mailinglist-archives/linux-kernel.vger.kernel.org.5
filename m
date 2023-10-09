Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4557BE1E3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 15:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377165AbjJINzO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 9 Oct 2023 09:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377601AbjJINzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 09:55:07 -0400
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E362FA;
        Mon,  9 Oct 2023 06:55:06 -0700 (PDT)
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6c623d55b98so422063a34.1;
        Mon, 09 Oct 2023 06:55:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696859706; x=1697464506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DbYSaAkppXiXwPywgJaYV/kJCNrZ4Yezq8j1jCwJ9gw=;
        b=AaxdZsCkw+tlye9GTa9lkjDafIxwx8PzI7csCeYi81riIISIjmWXJaDFj6CnL2IjlJ
         D5F8RruMoIKnDVoGHJXzbw6Bsp40s5cqftun4Mdj6VQ1nKWpZ+nyj+igoeR26kiWl9GC
         gw/pyiYMynCqweb0qpTRQ0LFyV/TPWaAy3XzmgxbAVOrzgaXYfyZFLR3IDI49j9YxP2i
         7mIuyt+i9Sekr/GXlPRjMSXEC1PHtPw82nzwZeSpAqX8NL6SJrhWaoUEYReC26O0KSIj
         QeukspOsJ8XVPApNUeoUnvtjKT0hvZcPq3vekUP+gKO/iCXPX6rNBeEINrVxn/1JW8i1
         yDyg==
X-Gm-Message-State: AOJu0Yy/ofKCoyuB8bztaLAA6HVBTvsXIFJD6OcG4M1xbaOVHTqesNxi
        WkakSz3lQW7OxXXRrEwnL8hiUs4EOBmloEK5Oo0=
X-Google-Smtp-Source: AGHT+IE2VRWkpXzrRv5siKgPmRUKaCxwWCJwWFC7kks38lnM7w5ZjjKOORJg03+CHic70zFb0JwtENEPLcu9N2QoEfE=
X-Received: by 2002:a4a:ee90:0:b0:57b:94b7:c6ba with SMTP id
 dk16-20020a4aee90000000b0057b94b7c6bamr13458447oob.0.1696859705868; Mon, 09
 Oct 2023 06:55:05 -0700 (PDT)
MIME-Version: 1.0
References: <20231006135434.3602921-1-lukasz.luba@arm.com>
In-Reply-To: <20231006135434.3602921-1-lukasz.luba@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 9 Oct 2023 15:54:54 +0200
Message-ID: <CAJZ5v0hiPcPWgqwmjpJhG4wG4WbSzkO8yxvVw5=ED8w3HNwBTw@mail.gmail.com>
Subject: Re: [PATCH] thermal: Add myself as thermal reviewer in MAINTAINERS
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, rafael.j.wysocki@intel.com,
        linux-pm@vger.kernel.org, srinivas.pandruvada@linux.intel.com,
        rui.zhang@intel.com
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

On Fri, Oct 6, 2023 at 3:54 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>
> Become designated reviewer and help thermal subsystem in development
> process.
>
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
> Hi Rafael,
>
> This should apply on top of your patch removing the previous reviewer.

Applied, thanks!

>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 63186c63cba6..70087a08d720 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21357,6 +21357,7 @@ THERMAL
>  M:     Rafael J. Wysocki <rafael@kernel.org>
>  M:     Daniel Lezcano <daniel.lezcano@linaro.org>
>  R:     Zhang Rui <rui.zhang@intel.com>
> +R:     Lukasz Luba <lukasz.luba@arm.com>
>  L:     linux-pm@vger.kernel.org
>  S:     Supported
>  Q:     https://patchwork.kernel.org/project/linux-pm/list/
> --
> 2.25.1
>
