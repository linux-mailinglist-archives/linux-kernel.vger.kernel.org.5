Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D43F578CC3C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 20:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238146AbjH2SgU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 29 Aug 2023 14:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238143AbjH2Sfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 14:35:55 -0400
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F431B7;
        Tue, 29 Aug 2023 11:35:49 -0700 (PDT)
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-573128cd77dso683116eaf.0;
        Tue, 29 Aug 2023 11:35:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693334148; x=1693938948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qXN7uMb1bNWccF39QUvfJywcxCvn0uW5/FhwVa/Jikc=;
        b=FklrWod4MnpyXoEWZwLk5WutxxrTz14IlvXVavrk5J1jd/UD23CgXmymKlOc1qz93T
         c/GpQQrTLPdM6ZmrGo8mg+nW7jhs7EU1cAoEM/W7TuMX4NuPPf0yxV4RjCMJAeTD8lJm
         Q0psuMd6wM4mRICDfK6lklSAMlA+xJNrYdIgxS9u7ayfm7+ce7Geu6ppDIR46NKqPIq7
         1PSsA/4qZXELwa3/gmzQ5ugm2ZjZOJ8gNomiZ+9MkDOguUbuHPHBGIO2pRetHMY1IAFF
         yLtgdSBdQZbRESOIAy7ikYgyajvE6Jwje1pdVurv5hhvRAD5jCT0S00Lh4K6tVZUJNrK
         fFsQ==
X-Gm-Message-State: AOJu0Yxh1fb7cM4WXA24Fff9rk6TIFZJS/2ca7hzci+rmcBSG6J+Oc7e
        GSONVJmsq+kxxLkFW2kWcFd1o6Mk/3mpdjOdBPo=
X-Google-Smtp-Source: AGHT+IGJkjFYdVMkWJE7bLv/T9zt3mQmVpmmoHvpmmobH3tVC9gKffbFL5Qaq1xZSTv1zh0+D741nIlTovnU/d2CtVs=
X-Received: by 2002:a4a:e741:0:b0:56e:94ed:c098 with SMTP id
 n1-20020a4ae741000000b0056e94edc098mr29432056oov.0.1693334148518; Tue, 29 Aug
 2023 11:35:48 -0700 (PDT)
MIME-Version: 1.0
References: <7f3f12a8-fb4e-fa6a-aeb6-5ebcdfddbee0@linuxfoundation.org>
In-Reply-To: <7f3f12a8-fb4e-fa6a-aeb6-5ebcdfddbee0@linuxfoundation.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 29 Aug 2023 20:35:26 +0200
Message-ID: <CAJZ5v0jntBdFXpFdC-UFypAPRhnvqMCEK4Ua7Ys7z_=P+HjEFw@mail.gmail.com>
Subject: Re: [GIT PULL] cpupower update for Linux 6.6-rc2
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
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

Hi Shuah,

On Tue, Aug 29, 2023 at 12:39 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> Hi Rafael,
>
> Please pull the following cpupower update for Linux 6.6-rc2
>
> This cpupower update for Linux 6.6-rc2 consists of a single fix to
> add Georgian translation to Makefile LANGUAGES.
>
> diff is attached.
>
> thanks,
> -- Shuah
>
> ----------------------------------------------------------------
> The following changes since commit 99481d2195bfd13a663904e6014887abf46b57c7:
>
>    cpupower: Fix cpuidle_set to accept only numeric values for idle-set operation. (2023-07-18 16:07:08 -0600)
>
> are available in the Git repository at:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux tags/linux-cpupower-6.6-rc2
>
> for you to fetch changes up to af75504c38960d5331b8c6c83ea9981e26d659e6:
>
>    cpupower: Add Georgian translation to Makefile LANGUAGES (2023-08-17 14:28:16 -0600)
>
> ----------------------------------------------------------------
> linux-cpupower-6.6-rc2
>
> This cpupower update for Linux 6.6-rc2 consists of a single fix to
> add Georgian translation to Makefile LANGUAGES.
>
> ----------------------------------------------------------------
> Shuah Khan (1):
>        cpupower: Add Georgian translation to Makefile LANGUAGES
>
>   tools/power/cpupower/Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> ----------------------------------------------------------------

Pulled, thanks!
