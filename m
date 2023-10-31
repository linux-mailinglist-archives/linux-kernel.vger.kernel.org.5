Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3A3F7DD651
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 19:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbjJaSu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 14:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbjJaSuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 14:50:25 -0400
Received: from mail-yw1-x1144.google.com (mail-yw1-x1144.google.com [IPv6:2607:f8b0:4864:20::1144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD69A3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 11:50:22 -0700 (PDT)
Received: by mail-yw1-x1144.google.com with SMTP id 00721157ae682-5a82f176860so58735347b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 11:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atozemailservice.com; s=google; t=1698778222; x=1699383022; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n1yy3NRcotcF5HAhbHFpobvDv2jttdyNWBgtCPGPokU=;
        b=RmJi8kibmSgaNSMvAfFavSB0BDdts1LV4L5VdGeeYrW3ETb2s3/z1wGTc7jG/JSQN6
         g0E9Iwr3G0B8ktP9lBrHGHsXyqD/WMgEZuQipxvM9rd1zQZrLy8Be71sYukFIrYaAz+p
         LqlxtFuGQ98KZ65R8OuKQA7c5c5lYUSNggMrOR3nerMLOqotvMR9U7c/hH8a61Ulkfbl
         ZjKXz67utpYEkwwvoL1ZpgWAcw3SeKmvkKnKYF3mx2wqLS0v3exG6sPDQ6kIlFex/mTh
         D7gdSYXPzYsPk488UUWyzZoNBwasDhC5Zaem7FlsapSGiwI1yOEB6RE7IEOIeizgEEnS
         n4Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698778222; x=1699383022;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n1yy3NRcotcF5HAhbHFpobvDv2jttdyNWBgtCPGPokU=;
        b=lO0o3ErHLFgXqThQT1GS2G1b/k+gETruOntUhZLibisbceBlisScsjzCnzTICSFEHp
         b58KHe6rM8FJHBct1vDIo/Y3EyP3zS/Znl3NnZBhKXuO+uFFMLGq25z3FU1vrOISycRS
         YUhLK9SdL0z/qz+PeuwAM7rr4RJ1egvzxyRDD0XL4h+nOud67PoBOraZnnsvUl1/IxBi
         S73HLR5MUGlUMzX2bwsPpbEoj7F6ehIL8F/0lFgZCKp1rHaCl0Bt8f5mD/O/bJa7JQLy
         PnbE5HJ7WeztEY+VLpGpfoY/N951JseRDZy0YLg9jkoStNK6q/2jaCwB2hg3VMTcno43
         y/Yg==
X-Gm-Message-State: AOJu0YwIB189F7TaY0rBW45CE0lPwxNh0RqaK3iXuIK4lTn8OTwVQT2y
        P4d6bT2ojObC1DiRv/yqDAazIaCkWma9OuJ33RBzwQ==
X-Google-Smtp-Source: AGHT+IEKuoscsWsZFdUlxF1orCGTVNXGtyhB3JCNvd+H/Nbd6ArnkpvkbvL5kZ7JUCOvDaA8bjE8aPKYSG2jqDOodCU=
X-Received: by 2002:a25:c78a:0:b0:da1:13b7:8a87 with SMTP id
 w132-20020a25c78a000000b00da113b78a87mr11594784ybe.15.1698778222064; Tue, 31
 Oct 2023 11:50:22 -0700 (PDT)
MIME-Version: 1.0
From:   Cora Howard <cora@atozemailservice.com>
Date:   Tue, 31 Oct 2023 13:50:10 -0500
Message-ID: <CALBRdJW_p6NA4MSQcxSnTEn0jrR0BWOg_EuLXg2c+4WR2SRXSg@mail.gmail.com>
Subject: RE: PACK EXPO International Data-List 2023
To:     Cora Howard <cora@atozemailservice.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Would you be interested in acquiring PACK EXPO International Data List 2023?

No of Contacts: 40,526
Cost: $1,917

Interested? Email me back; I would love to provide more information on the list.

Kind Regards,
Cora Howard
Marketing Coordinator
