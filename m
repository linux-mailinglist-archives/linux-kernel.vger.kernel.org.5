Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C55F97EF899
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 21:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbjKQUVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 15:21:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjKQUVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 15:21:49 -0500
Received: from mail-oa1-x41.google.com (mail-oa1-x41.google.com [IPv6:2001:4860:4864:20::41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D131120
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 12:21:46 -0800 (PST)
Received: by mail-oa1-x41.google.com with SMTP id 586e51a60fabf-1eb6c559ab4so1269965fac.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 12:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=healthydataprovider.com; s=google; t=1700252506; x=1700857306; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lfBG3wpv71smcZXEDIfsS0xK1hS13iptlrh35h5mv9M=;
        b=TJOm5RXkpcUG0QSlFocAQ/f1QvK4Rl/zcPLEK2jC6xYIB2TmJAQZ7sjOwESWQLzu/8
         QCAjsX3WT4BFX25eapMKz2Gj6u9F7NZ39ARKZihi3wj5Ql1/ys+PCxl+4Z/sw1yQ/Ez+
         AifnL3CVUE9nCtWx7itHx51W0G6M8EiCpEn47IkcQdNL1s55hr7kWkWBklIu+0OKYxLJ
         Mn2Bt9Riu+iArsBlF6OWFz76WX6cm1tn3eBPpLcCKcskLeCOp3ngqsS9FszNSWLYgy+J
         lt5Kf5FgYiv3vXPmfKjRqcbXEZvGsjcpSFG/3WSNJMpUEYmhplvpOkREVmf+gJER6P+Q
         hcTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700252506; x=1700857306;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lfBG3wpv71smcZXEDIfsS0xK1hS13iptlrh35h5mv9M=;
        b=u2GEnixVxl2PozyMpxV8bFsXwC6UgGXndT2PFzIYGcVR4fgrm4BknVcoXTWngHcv6+
         8m8Ao7GdDMIYyLBdHzO6S5u/1qGVprKVEC0E66pSj6cotp3irNeUlyabX7PlvhimKOpA
         TuDZDwJkL2kIvjT06UNbcHvAXo+rYMg3WsdHmxkmtF26P8kcRigEM6mgXjLfMKlIGLii
         CYiA6zcHp1LCgwEy6F0JDRxBdUv5sq1BQvg2hM9AGAltQqcXSNtVHnRhEQhZ/SyWjhM1
         M/Zrdjy7EO8CppfBhqDHx2SfvOMT9TcNKsxKh0x8Bb4aQczMBeofD44BZLez2uTVsVNw
         EMxg==
X-Gm-Message-State: AOJu0YxUmTkrreNFRyH3pPlMOHrBbalk893o3K0lBjdujJGqyX/lHlSO
        F9NmPt8oYrMU1s+mUCSvmVZOhuEUSFGnRhXDbKjvxQ==
X-Google-Smtp-Source: AGHT+IFXuqV2numuPfyTJchq2qqdADa2NdqViU2G1+Bb1yZG1XAodN4sxeVSoNGIvHT/P0ItAjJ7ZJy3QFWL+ZHd7GI=
X-Received: by 2002:a05:6870:41d3:b0:1e9:e0f3:d716 with SMTP id
 z19-20020a05687041d300b001e9e0f3d716mr302446oac.37.1700252505699; Fri, 17 Nov
 2023 12:21:45 -0800 (PST)
MIME-Version: 1.0
From:   Rose Frank <rose@healthydataprovider.com>
Date:   Fri, 17 Nov 2023 14:21:34 -0600
Message-ID: <CAEBxSDzim+_W+4PkQVH4sk7thgHu1atoUek0beWcd6=bhH4qqA@mail.gmail.com>
Subject: RE: AWS re:Invent Registrants Email List 2023
To:     Rose Frank <rose@healthydataprovider.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Would you be interested in acquiring the AWS re:Invent Email List?

Number of Contacts: 42,486
Cost: $1,918

Interested? Email me back; I would love to provide more information on the list.

Kind Regards,
Rose Frank
Marketing Coordinator
