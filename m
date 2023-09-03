Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2BB790B3F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 10:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236095AbjICIgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 04:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236047AbjICIgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 04:36:49 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1407CD
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 01:36:46 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 5b1f17b1804b1-402cc6b8bedso917565e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Sep 2023 01:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693730205; x=1694335005; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LQLO7aaH2b9rfQpQmLo19KMj34+AhfX1whSrT748ylE=;
        b=UowASRcAwVXJABDTjtQ4aHZ5l56V660nZbmqRRyDx6kwkdDJ/BgyjsZTDHO1GvmbJA
         zkVvv+I8WNKAlPCY7sbYNmwDVhLIQtFwqfmLSsohzU4dh88AXA8+AW91YnaSBsfmNauA
         2JBMVIyR/lT2EF8vWlCGcaKfQwImHnDDq5kFDPvp0MyN9ELfSr2LJae6WiCzVAjQeV0s
         CpwUcJFdla2P6AVD8nQBwGD0iKSulzE5rDo+oFVSgTi0iGR2mcKncxwoL3Yh/lhcOyEB
         IlJnWgyUP0T3Oa4XfPhbxxd3IGWWiMVCB7+D5hrdJ1JyGPLFn+yY4iQns+eB/mSk0XpA
         1UOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693730205; x=1694335005;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LQLO7aaH2b9rfQpQmLo19KMj34+AhfX1whSrT748ylE=;
        b=PjOo3a1PMxsw5dpvYON/CXl1KMOwqiAlDlW1jS/c4AOvhhNhp2klVWzNXU+LTpQDH3
         0+5iKU5gDupu05rabg9vZ+uc3d3JHGwOWIIVyINjGgCVZ27gjtZVgO/FEt1l6/XXemn1
         kO9ZIm8xhRB0MD5VDNs8Nf+np+ZsLINaeuSE9eAljRvrlW0CmvAbURRJRzkda35MsYXY
         z40CEpaCxLx/3QSuKk/m2MpC6oTxb40+IgujwRW0CdrURjiRemM6XIQYGZbCD4kPWHhb
         qSqQvxidoBXJuQi5BHTauAd6YZZCG5LrjohAI2C+gNJpmrnF8Ic8ezhE1veDa4jXPPIg
         0qjA==
X-Gm-Message-State: AOJu0Yz0FThZUnJOesgxLr243D2ypnXm5Cig6a4vzZ/3uoystDNNjuqx
        kPVZl8vR8UEG8TfcQt/4tNW3EzH0s5InZat9Yg==
X-Google-Smtp-Source: AGHT+IHzRF8Raaa027tGXfk7dO62krXvPlJbebmvN5pnVHSN+ne3qot7+U38N/3ykD6KPd+hyStm/4Hyv7yw+GiR8VI=
X-Received: by 2002:a05:600c:205a:b0:401:264b:5df7 with SMTP id
 p26-20020a05600c205a00b00401264b5df7mr4782063wmg.35.1693730204836; Sun, 03
 Sep 2023 01:36:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5d:6945:0:b0:319:652e:95f3 with HTTP; Sun, 3 Sep 2023
 01:36:43 -0700 (PDT)
Reply-To: ran32ke@aol.com
From:   Hussein Khalid <aymanabdulaal989@gmail.com>
Date:   Sun, 3 Sep 2023 01:36:43 -0700
Message-ID: <CA+NzZL9ZVC+faBxLavHgneCfUcOsiE+g+bCasNJEf5PScbtekA@mail.gmail.com>
Subject: Loan For Business
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello,


My client is seeking for someone who has a solid background and idea
of making good profits in the above mentioned business or any other
business in your region which involves co-operation of JV Partnership
funding.

He is willing to provide funding or Loan for any viable and
sustainable investment project.

Let me hear from you


Kind regards

Hussein Khalid
