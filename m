Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D63A770E29
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 08:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjHEGn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 02:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjHEGnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 02:43:52 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D271BF
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 23:43:51 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99bccc9ec02so405260566b.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 23:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691217830; x=1691822630;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fyaf0OHfvWgaqfRiwRufcy49gz6rXRNyNLf1qH0Ffk0=;
        b=fI0IdoXOvcDFp/TFe6tNB54+yAWSvxH8Zh+XLrDZpTuld3fJbS+DuZSFLqW9YgqseX
         4akrMUkIlH8A0RNQ6uZlBhD2vSl/tI88Emx+HHrckk6iT4w9aEIRRx+1k6VfpsVQDKET
         TY22K+Oh1gjSIPZJLmNpRq1eDvzRJ4UevCHDGQX0lehvFOsopQgcVZQ+2WZIbRPkfP53
         4qU8wFITjBLvOLBE7aLOQSW/jJAUxTtZKtAszb8gjPMsXb0fS9ZtB5x9eatYR8U5kLFU
         lWiQGpOnzqf4wyGILyBl9gEPbX9iLal1b1N5lJPHKxYkC8AjSMUaS8OwwptUs5POiCPI
         EyDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691217830; x=1691822630;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fyaf0OHfvWgaqfRiwRufcy49gz6rXRNyNLf1qH0Ffk0=;
        b=b7piTS3BOdx+7nMi7GZEidPabAlusqbnFK3ZBro1ctypYwWzSqLq12z3+70HIjeZsV
         2Yp6WFy5Wz4U4Y/9dms89ccI5TNs4H1Ohscv/IWn4FnK+Bu1NhgEAwMRgyObDK6IdPfG
         d4P/E7WHxdIJp+yLYY8oeSfAczvcp5ISp1tFB2OXDrH09580qts15lRqXYqgIQJ4dXKU
         2e9S/2gr3neD4+1Fz5hJIpRFBgCN3Lt0Dm5oFacrD/HyEZpnmqcUxQHJHJuAdi3xiI/f
         /GMMCe2MjqkMYaOmenO9oLRZsymHDsbh7E2LfE2vEdKd5wSMkczJelRolA5EAyPe0tgM
         wG+g==
X-Gm-Message-State: AOJu0Yz/sagdxkwlsTFt2KbB00JRO41d8x8ggi9iVGqGHwQaQvEkS2Hk
        fPA02kexSPjQiZGf23uiJvEQRk7x1yu0NIW1DiA=
X-Google-Smtp-Source: AGHT+IEl1NuIN82xxyrBQD+s/Zn0M7QFkGsXZ4ZFmr6qZ9EP5GvkrTWFyE2VXvpsTcPx0h/SafTKp5lqA2W+yRb//ws=
X-Received: by 2002:a17:906:1c7:b0:99b:22dd:f83d with SMTP id
 7-20020a17090601c700b0099b22ddf83dmr3797948ejj.55.1691217829572; Fri, 04 Aug
 2023 23:43:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7412:6629:b0:df:940:19b1 with HTTP; Fri, 4 Aug 2023
 23:43:49 -0700 (PDT)
Reply-To: bintu37999@gmail.com
From:   Bintu Felicia <bimmtu@gmail.com>
Date:   Sat, 5 Aug 2023 07:43:49 +0100
Message-ID: <CAAF5Ruxz2Ewx0JS8DadqixYJ1dMiUNHqMW7dT=ZCAgF3-FRb0w@mail.gmail.com>
Subject: HELLO...,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

How are you today? I hope you are fine. My name is Miss
Bintu Felicia . l am single looking for honest and nice
person whom i can partner with . I don't care about
your color, ethnicity, Status or Sex. Upon your reply to
this mail I will tell you more about myself and send you
more of my picture .I am sending you this beautiful mail
with a wish for much happiness
