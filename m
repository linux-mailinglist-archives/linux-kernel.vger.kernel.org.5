Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D237686CB
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 19:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjG3Rgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 13:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjG3Rgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 13:36:52 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABEB5B2
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 10:36:50 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b9c907bc68so45151871fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 10:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690738609; x=1691343409;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8EJGgzQqutJFDlzcKppgukpynrnTTIYEegbSwRHtF+g=;
        b=dwlur2vcNk+3lQbYsHR8idChosu1y732RAlIpWVi2Gi3ltkSqq84OlhNlAyOlhOCzn
         XzfGKbht41Zu6/j9l1ihwpokKwxeNpKuou5cREB/l8+0W7xO3F1l1r68Lozr+jezR493
         ndhSNksE08NDXp8aQbo+/VPYsj7cOPCMufduk7XYoPIozd2B6aC22QvWbaVaOV0H5XdF
         NmSrLL9yk3jB6Q2D2IF+8ODl66GKmsTVXH73J2du/brT05gU/p1NjCiW1TMGlfRyZrPN
         Dqyx6zXWTLg0YBWCxwhMl61GXUyw1vO185r5mYwmRNyTO+PTIT6iEJSs0PeKnJZwxk9s
         NewA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690738609; x=1691343409;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8EJGgzQqutJFDlzcKppgukpynrnTTIYEegbSwRHtF+g=;
        b=E0Kg8C89kbb+RrlB0MVGNPyoI9Hq7gPIvWT5NvXG71cMAKy40r7G+FxPsam6+I/XR+
         czfduuzC5oSGfGjDSCZya4kIdMrI0RZjZKwAsp/+pJ12RMQ7qLF5cdgSGXo9tL6GVvCV
         QaoIT6TEerjLVSleUq+b7rLngFHGy9nmRsFs66DoJnLt2FLfj+b6H9gGrDBJIKejabtu
         GyZ7kfuIF8G5FnAJM6vzqpJohy5mCxG/0mHfuKOCndhVbA402DBGAHFKqcJfjYEuusHe
         KeAQUDNQSQefKBNVCS3pSfeqUUDRpguzdMsgTrpr4/FaWuAWvvxOyKFmOjBfkNnxkF8n
         Jk6A==
X-Gm-Message-State: ABy/qLZz0LTPsCvQVWTZDMb2lLHFSnCrMmzPNFBpoDHbCD6iRvykB6ma
        pBggWEmz+HDbqqOYldIBCKKUtt6B9vF7EDBo/bc=
X-Google-Smtp-Source: APBJJlFNq8w39Oiu+stRgSEVBSeXWmslJ2ZBZW0373IZUigP4IM+c/xMilssyj89v2nzXKrCRxrAII+oFkfrgogOSFw=
X-Received: by 2002:a2e:b6c2:0:b0:2b6:df25:1ab0 with SMTP id
 m2-20020a2eb6c2000000b002b6df251ab0mr5200834ljo.34.1690738608692; Sun, 30 Jul
 2023 10:36:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:82ca:0:b0:2b9:a622:1baf with HTTP; Sun, 30 Jul 2023
 10:36:48 -0700 (PDT)
Reply-To: fionahill142@gmail.com
From:   Fiona Hill <briandickson084@gmail.com>
Date:   Sun, 30 Jul 2023 17:36:48 +0000
Message-ID: <CAOUDwrAO7zUk1==3qAtP=udA2zDQ_PPMuCcAxMkDpPvH1dWfGQ@mail.gmail.com>
Subject: Hello, did you receive my email?
To:     fionahill142@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=2.1 required=5.0 tests=BAYES_50,BODY_SINGLE_WORD,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SCC_BODY_SINGLE_WORD,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5L2g5aW977yM5L2g5pS25Yiw5oiR55qE6YKu5Lu25LqG5ZCX77yfDQo=
