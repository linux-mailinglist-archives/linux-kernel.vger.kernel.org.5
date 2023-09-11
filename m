Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C06079B314
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240653AbjIKWjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241884AbjIKPRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 11:17:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38786FA
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 08:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=MeQY0pI6Zdhk2aGEY5C7WS4yXEnfwTtX1HkrUhW3Hg0=; b=XbE3TYgW+q3blziN3ZcPDUnJRd
        nbEAZVj0pfUkdV4I3Yf6kvA9JDQvvSP9jDtNAegWVJe/dWQESfYn3bO94ny2na0usCfgqvSMwVRWA
        RzaAQKpGP27xwmG2D0GQWejHDqjygn16Zd3ic9BNAznKEjqDXpO91FdTEHNe8iX4vQJJmSjXDoKbZ
        11d2jBsm9akr6xvVkBasApmU4Cir5WpgusgedNHEioSD8VY+EQ2+1Krq3AU8WRdWRKzLG4q9ziKmu
        buAeB1wzSkd4tzTyIfIhClj7TYzGdJuHZ23sABndE4vNQl6LtjYlcC1vrSWZSdXzmh/1jMEI19R5i
        /57sASgg==;
Received: from [2601:1c2:980:9ec0::9fed]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qfien-000rEs-0s;
        Mon, 11 Sep 2023 15:16:57 +0000
Message-ID: <e8114d08-724d-d3f8-96a8-9872bf947f3c@infradead.org>
Date:   Mon, 11 Sep 2023 08:16:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: (subset) [PATCH v2] drm/connector: document
 DRM_MODE_COLORIMETRY_COUNT
Content-Language: en-US
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20230906-topic-drm_connector_doc-v2-1-1f2dcaa43269@gmail.com>
 <169409716450.2201230.1132363284756871897.b4-ty@kernel.org>
 <87il8hf1p5.fsf@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <87il8hf1p5.fsf@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/11/23 03:23, Jani Nikula wrote:
> On Thu, 07 Sep 2023, Maxime Ripard <mripard@kernel.org> wrote:
>> On Wed, 06 Sep 2023 22:47:38 +0200, Javier Carrasco wrote:
>>> The drm_colorspace enum member DRM_MODE_COLORIMETRY_COUNT has been
>>> properly documented by moving the description out of the enum to the
>>> member description list to get rid of an additional warning and improve
>>> documentation clarity.
>>>
>>>
>>
>> Applied to drm/drm-misc (drm-misc-next).
> 
> After the fact, but adding /* private: */ would've been an alternative
> approach. I think support for that for enums should be there.

Yes, that was the first patch that I sent....
but nobody picked it up.

> 
> Anyway, just for future reference, the merged patch is fine.
> 
> BR,
> Jani.
> 
>>
>> Thanks!
>> Maxime


-- 
~Randy
