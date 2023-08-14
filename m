Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE6777BBEB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 16:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjHNOqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 10:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232367AbjHNOqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 10:46:19 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E99C10C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 07:46:17 -0700 (PDT)
Date:   Mon, 14 Aug 2023 14:46:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail2; t=1692024371; x=1692283571;
        bh=JgHL4UkB62lNPVFi4VtHc4HqfqxAHV8a9vkTMUKP2EI=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=TA2unefP/rpLSJlZorCbVA6ebVkM/k5ec9jj5gioCQzF6wad97lvLeJcM1EeAKlZV
         L5BQj4KBiDty5o8qRv+w/Id63YQYHoshmHMrYZVzyhtdjtMyQnM8RWhq17v8guLPlo
         XA0cid0ft6SfJGFOqjj9UbJDcC8UDa11tdQVllw4M6OU/gPbPZ51JZ0suWD/FU9tFr
         cqBr7eyixIOCcVKPUmr94rwVGBAh5pK4hOpVKue0GEw5mcluC6nOFkmJ/Fux9v28uL
         iBKnXONhJonrMNTOgVuxnJcp2L+pOPNRJ73+HH6VAY2RU1GAA7eeM92XdWwhGp40XJ
         B6CItkfrPu57g==
To:     Maxime Ripard <mripard@kernel.org>
From:   Simon Ser <contact@emersion.fr>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Emma Anholt <emma@anholt.net>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH RFC 03/13] drm/connector: hdmi: Add Broadcast RGB property
Message-ID: <lU58OYuuI5kXdktRrB0ihxVgpjmtFX-AUMWy_9kbIFm0k27T8hNwNJxdO2UB3wVk_4Zdn7aZAl14V_hpmPoZg1cgIfizIbH5JLL0k7-UGzc=@emersion.fr>
In-Reply-To: <20230814-kms-hdmi-connector-state-v1-3-048054df3654@kernel.org>
References: <20230814-kms-hdmi-connector-state-v1-0-048054df3654@kernel.org> <20230814-kms-hdmi-connector-state-v1-3-048054df3654@kernel.org>
Feedback-ID: 1358184:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+1 for a standardized property. wlroots is blocked on the kernel
making this property standard before starting using it.

Can docs be added in the "Standard Connector Properties" section?
