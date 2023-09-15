Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67E667A13FD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 04:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbjIOCvM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 14 Sep 2023 22:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbjIOCvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 22:51:11 -0400
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F3A269D;
        Thu, 14 Sep 2023 19:51:06 -0700 (PDT)
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7926b7f8636so44483439f.1;
        Thu, 14 Sep 2023 19:51:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694746266; x=1695351066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SerwLE5OVRCSsMUALrCrul+Mnyrmcl1kTZ8zMma6b1o=;
        b=FAKpv2G6HUccpr01sjH4+2qlUxPDER3poXLyVZHpo8Cwmxwm8wF98Rb/BxbM9yBHac
         OVNezVj9W4A/w3/vCXEyrD2T3FJLELgkpvGV6MMt9F8TPPdTZ/fR1xoJQvCYmqZBMTkw
         BHES2yVljBmzTms92gPaN4vnQCvrf5cn1aKpyJTf/ZklAvfbqWcehBR0VACAlM8o950I
         JG7qV/NPItGu88iz8moqLZ2LW9Y1xRmstoCUEcqdZYytYXVlhNRdwnqjsqtZNyO1VRHH
         mNr6aizBw2bx+oJHGxt4XHfE4nTRPbr2xcqyGS4uOMrczg2/iCe4Wa72QuEEw9Pf6Bqz
         Te8w==
X-Gm-Message-State: AOJu0YzdJTNzZvVcj/1TySkGavpH3tJ+vuHfjo3KJdHv7pP6uAiw1tYH
        xO+BXU0m+6UuNPQ7oYPs+3+G3ZB4QxkAHMPkmQo=
X-Google-Smtp-Source: AGHT+IEUe8v4V3sEbZQZK3qoizJ7mO2YNsUs9lirdL0XqpRAFuTBJPPN5owc9FGVgcGfqB3vgcnQBzk6VHKxqA8rkVI=
X-Received: by 2002:a5d:9ac2:0:b0:785:d5d4:9f26 with SMTP id
 x2-20020a5d9ac2000000b00785d5d49f26mr468980ion.9.1694746265984; Thu, 14 Sep
 2023 19:51:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230915072642.74e3c00f@canb.auug.org.au>
In-Reply-To: <20230915072642.74e3c00f@canb.auug.org.au>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 14 Sep 2023 19:50:54 -0700
Message-ID: <CAM9d7chQmD2RRazcC+R6SgJtx8OoEEuSS6CkzCuTJAFKy0-TtA@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the perf tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Veronika Molnarova <vmolnaro@redhat.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Stephen,

On Thu, Sep 14, 2023 at 2:26 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Commits
>
>   19d8ab40f89b ("perf test stat+shadow_stat.sh: Add threshold for rounding errors")
>   0c4ded92280b ("perf test lock_contention.sh: Skip test if the number of CPUs is low")
>
> are missing a Signed-off-by from their author.

Thanks for the notice.  As they're recently added, I think I can replace them
with new commits with s-o-b from the author and force-push.

Veronika, can you resend those two commits with your Sign-off?

Thanks,
Namhyung
