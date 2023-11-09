Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9C907E7270
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 20:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbjKITrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 14:47:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbjKITq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 14:46:58 -0500
Received: from mail-yw1-x1142.google.com (mail-yw1-x1142.google.com [IPv6:2607:f8b0:4864:20::1142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB5E3C19
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 11:46:55 -0800 (PST)
Received: by mail-yw1-x1142.google.com with SMTP id 00721157ae682-5bf812041a6so10484367b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 11:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atozemailservice.com; s=google; t=1699559215; x=1700164015; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uVp7KhZbQqAuDwlnZ8I4g8RlBzWjjE1DmZHmqp+XyBc=;
        b=FD4R8djd0NhBJjP99GbW1AZI3ISqdf2OULC5JNUL7PYlb4YxNPxdgqf95kFCjY4xLY
         V6S+QCWx1KDQv0Y/TUFIeTMwmSEuxoocGlrlp6Y7McMgt7a9mjCZPK9/kD2/axFTajWM
         NgS230+tyGgHyDeO5siVl+wSUraTbnY71E9nn5HU0lfLu3/Q0ltQvH9W0hsUSZaTIbn/
         ZY1SsLp8g/Kwy8R+XogkzyjxOKZ/kDCENXf2UbIs/ev06RWXw7qNkzjJjNH143knr/vx
         1diYA2ZMCRT6X46d5quqrsKLNn+SXNxR74dS1QyYGFFGNTxplluZGv5dd4fbwuw9mlt6
         abtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699559215; x=1700164015;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uVp7KhZbQqAuDwlnZ8I4g8RlBzWjjE1DmZHmqp+XyBc=;
        b=cQ6VnTSOObTUbY/xOZJBIqj8pFJBFcRU76jQFY2tfLg1ij8F2ynS2dpxpr7izGWMBV
         5P5NvOtXbrz3xscR8FSdf9MkrzN2DLiMu9hB9d8ttHldYhUPesj8kulqf70p9y8i8hF6
         yOsNLXTyEEI1kSp+6pl9hdBnL6lgzCeMsW00qIoIrpOE7JzOUYfpDscnWszOttRNFjhw
         8oyR8qrcycjdQ+6DTV7Ru9L646LMOPRloGfLHwlz9CbUakORsV+FA+YEpgjVHORaBo5Q
         i2bAtwSspYnXdoXiC0XS89mGUihkJVxV6tpnGLZ9S13TBzGwrscoapnABPg7Q5UfB/cP
         tL8A==
X-Gm-Message-State: AOJu0Yy71w+Pm0m17gHL68zYfWrnT1Kh9IsHwytH17I+XW6bnJXlhbHa
        w+cHY+hbAiCHsjYdMjoVeGLHCr2lTO7qO3FNGFExIQ==
X-Google-Smtp-Source: AGHT+IERXyTB4f87PhCL0fiNKoe5Kb8Q+fgImjXYNCyOO3vgfzjMwMheZcH9LaUvhUSw+ychXudDfLak9W/ctLSuZsc=
X-Received: by 2002:a25:547:0:b0:da0:e250:15ad with SMTP id
 68-20020a250547000000b00da0e25015admr5722793ybf.30.1699559215166; Thu, 09 Nov
 2023 11:46:55 -0800 (PST)
MIME-Version: 1.0
References: <CALBRdJW_p6NA4MSQcxSnTEn0jrR0BWOg_EuLXg2c+4WR2SRXSg@mail.gmail.com>
In-Reply-To: <CALBRdJW_p6NA4MSQcxSnTEn0jrR0BWOg_EuLXg2c+4WR2SRXSg@mail.gmail.com>
From:   Cora Howard <cora@atozemailservice.com>
Date:   Thu, 9 Nov 2023 13:46:42 -0600
Message-ID: <CALBRdJXKxm=XWAPsObDuhf9frE94Ddtka8o6Ex4kGLFrXB9uow@mail.gmail.com>
Subject: Re: PACK EXPO International Data-List 2023
To:     Cora Howard <cora@atozemailservice.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Did you get a chance to review my email?

Please let me know if you require any further information to take this
forward/make progress here.

I look forward to hearing back from you soon.

Regards,
Cora Howard

On Tue, 31 Oct 2023 at 13:50, Cora Howard <cora@atozemailservice.com> wrote:
>
> Hi,
>
> Would you be interested in acquiring PACK EXPO International Data List 2023?
>
> No of Contacts: 40,526
> Cost: $1,917
>
> Interested? Email me back; I would love to provide more information on the list.
>
> Kind Regards,
> Cora Howard
> Marketing Coordinator
