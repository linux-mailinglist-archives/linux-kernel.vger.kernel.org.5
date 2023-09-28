Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A65497B2887
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 00:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbjI1Wpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 18:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjI1Wpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 18:45:53 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5E719D
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 15:45:51 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-59bf1dde73fso172808467b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 15:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695941151; x=1696545951; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=nrbutzCAjK8QtmCFYJ6peo7ssDX3YAKduISqZF4P1OoK/dbJ6u4JgCzfRu1+F5Fsty
         SMnF6seJ/YVlYgoFhOgqZwOxfLsvrGxV5AZdjojiKPRlbPjwIuYp9v2x2nOUf63ap0x5
         2pJiA2dJ+Ea5qcLp/B5NAeFcmDWlbMFmLgM+j0/OBM1SCfoYGGoLbUSEsC42XCbvk2eX
         xPRKDi0H6olHlZqpTB9dJRE2mmgnFwwG0nkeaRjYXfYghB2fRnqXaCTmz2Dny6iKvXxw
         XXTvlKF890PWZArm8ftP9vPJSzvF0Ynf4sqpVfKxQHNQ1JpC0TNwetJyPyxCIbgknMiL
         vZJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695941151; x=1696545951;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=bpE3526ebEUtDOi5hrhpw1nKQf7vixLigNnuHfW32Ycj/eA2REOvmCDvFh+L0kMvAr
         haDDssF6ft0+IXDud7miP4Eg8Na7vyyed/84JASQt3Wzxq1xnXLs+XuI8p3LVo5CY92e
         l0NhL7UBM81rG21s7sv1iy7o7gzurWX49OifOLW0qwUwEuwUkugSKewKrSU2R3hfqqum
         e//0JmCjuU+TyThBnmJr2ArnO7iaUnSi5kZ0ryBkhFqlS9Sd99ljBpUYatR++Lj/+usF
         fgi1b63611u7vEsQ7+SZS6dbnI1dm9oi1lUYV7PRCnO6PKYDV9GZKwwt8q3MiCGCmVq9
         KyYA==
X-Gm-Message-State: AOJu0YxK2KIyZF7Dl7sL8XdoOK1MWKp1McVyLIct/O65CiN/aQee6VwM
        2dHtVrpFfhTwOj5TZ6tyzOZJOmjzANFF0q0a/lrfEFweIFs=
X-Google-Smtp-Source: AGHT+IFlsOlyZomgh/PV2cH+hT1bZW2iNCTvLbShLtVsFWsvgMz2mkXDJOP1vHfR2tK0SU1tuKe0bHz/+bv9i9CjL74=
X-Received: by 2002:a81:de4e:0:b0:592:5def:5c0d with SMTP id
 o14-20020a81de4e000000b005925def5c0dmr2619393ywl.45.1695941150961; Thu, 28
 Sep 2023 15:45:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7010:1409:b0:386:8bb3:6703 with HTTP; Thu, 28 Sep 2023
 15:45:50 -0700 (PDT)
Reply-To: kenmorganlawhouse@hotmail.com
From:   ken morgan <kenmorganchambershouse@gmail.com>
Date:   Thu, 28 Sep 2023 22:45:50 +0000
Message-ID: <CALDkM7L8dz+axmdOtHD+tGXUiCAb3q+XQUcTWN=0bVJoD-Pxhg@mail.gmail.com>
Subject: Hello my friend, a very urgent and confidential message kindly get
 back to me for more details?
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,EMPTY_MESSAGE,FREEMAIL_FROM,
        FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM,URG_BIZ autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1135 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [kenmorganchambershouse[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.6 URG_BIZ Contains urgent matter
        *  2.3 EMPTY_MESSAGE Message appears to have no textual parts
        *  2.6 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


